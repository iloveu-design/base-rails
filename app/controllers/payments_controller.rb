require 'csv'

class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
    @anniversary = Anniversary.unscoped.find params[:anniversary_id]

    if browser.mobile? || browser.tablet?
      @bank_helper = BankHelper.create
    else
      @bank_helper = BankHelper.new
    end
  end

  def create
    if browser.mobile?
      @transaction = Transaction.build_transaction_mobile( params )
      # logger.info Transaction.build_transaction_mobile( params )
    else
      @transaction = Transaction.build_transaction( params )
      # logger.info Transaction.build_transaction( params )
    end

    if @transaction.payment_type == "seedmoney"
      @payment = Payment.new(price: @transaction.price,
                              anniversary_id: @transaction.anniversary_id,
                              tid: @transaction.tid,
                              result_code: @transaction.result_code,
                              payment_type: @transaction.payment_type,
                              nickname: current_user.nickname)
      unless @payment.save
        render 'new'
        return
      end

      anniversary = Anniversary.unscoped.find(@payment.anniversary_id)
      anniversary.update(has_seedmoney_payment: true)
      user = @payment.anniversary.user
      user.update(role: "sponsor")
    elsif @transaction.payment_type == "temporary"
      @payment = Payment.create(price: @transaction.price,
                                anniversary_id: @transaction.anniversary_id,
                                tid: @transaction.tid,
                                result_code: @transaction.result_code,
                                payment_type: @transaction.payment_type,
                                nickname: @transaction.nickname,
                                bill_name: @transaction.bill_name,
                                bill_address: @transaction.bill_address,
                                bill_phone: @transaction.bill_phone,
                                ssn: @transaction.ssn,
                                buyeremail: @transaction.buyeremail
                                )
    end
    @transaction.payment_id = @payment.id

    if @transaction.save
      if @transaction.result_code == "00"
        redirect_to @payment
      else
        @payment.add_fail_error
        render 'new'
      end
    else
      render 'new'
    end
  end

  def show
    @payment = Payment.find params[:id]
  end

  # 모바일 신용카드, 모바일결제 callback
  def post_paid_users
    if(params[:P_TID] == "")
      @payment = Payment.new
      @payment.add_fail_error

      render 'new'
      return
      # params[:P_RMESG1].force_encoding("EUC-KR").encode("UTF-8")
    end

    # request url로 결제 요청
    uri = URI.parse(params[:P_REQ_URL])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({ "P_TID" => params[:P_TID], "P_MID" => ENV['INICIS_MID'] })
    resp = http.request(request)
    result_str = resp.body.to_s.force_encoding("EUC-KR").encode("UTF-8").tr(" ", "")
    logger.info result_str.tr("\n", "")
    @result = CGI::parse(result_str.tr("\n", ""))

    # create transaction
    t = Transaction.new
    # p_noti = CGI::parse( @result["P_NOTI"][0] )
    p_noti = @result["P_NOTI"][0].split(",")
    anniversary_id = p_noti[0].split("=")
    payment_type = p_noti[1].split("=")
    bill_name = p_noti[2].split("=")
    bill_phone = p_noti[3].split("=")
    bill_address = p_noti[4].split("=")
    ssn = p_noti[5].split("=")
    buyeremail = p_noti[6].split("=")

    t.tid = @result["P_TID"][0]
    t.result_code = @result["P_STATUS"][0]
    t.result_msg = @result["P_RMESG1"][0] + @result["P_RMESG2"][0]
    t.pay_method = @result["P_TYPE"][0]
    t.moid = @result["P_OID"][0]
    t.price = @result["P_AMT"][0]
    t.pay_at = @result["P_AUTH_DT"][0]
    t.card_code = @result["P_FN_CD1"][0]
    t.vact_num = @result["P_VACT_NUM"][0]
    t.vact_bank_code = @result["P_VACT_BANK_CODE"][0]
    t.vact_date = @result["P_VACT_DATE"][0]
    t.vact_input_name = @result["P_VACT_NAME"][0]
    t.vact_name = @result["P_VACT_NAME"][0]
    # t.payment_id =
    t.anniversary_id = anniversary_id[1]
    t.nickname = @result["P_UNAME"][0]
    t.payment_type = payment_type[1]

    t.p_vact_time = @result["P_VACT_TIME"][0]
    t.p_auth_no = @result["P_AUTH_NO"][0]
    t.p_rmesg2 = @result["P_RMESG2"][0]
    t.p_noti = @result["P_NOTI"][0]
    #mtrn.p_next_url = @result["P_NEXT_URL"][0]
    #mtrn.p_mname = @result["P_MNAME"][0]
    #mtrn.p_noteurl = @result["P_NOTEURL"][0]
    t.p_card_issuer_code = @result["P_CARD_ISSUER_CODE"][0]
    t.p_card_num = @result["P_CARD_NUM"][0]
    t.p_card_member_num = @result["P_CARD_MEMBER_NUM"][0]
    t.p_card_purchase_code = @result["P_CARD_PURCHASE_CODE"][0]
    t.p_card_prtc_code = @result["P_CARD_PRTC_CODE"][0]
    t.bill_name = bill_name[1]
    t.bill_address = bill_address[1]
    t.bill_phone = bill_phone[1]
    t.ssn = ssn[1]
    t.buyeremail = buyeremail[1]

    t.save

    # payment create
    if payment_type[1] == "seedmoney"
      @payment = Payment.create(price: t.price,
                                anniversary_id: t.anniversary_id,
                                tid: t.tid,
                                result_code: t.result_code,
                                payment_type: t.payment_type,
                                nickname: t.nickname)
      anniversary = Anniversary.unscoped.find(@payment.anniversary_id)
      anniversary.update(has_seedmoney_payment: true)
      user = @payment.anniversary.user
      user.update(role: "sponsor")
    elsif payment_type[1] == "temporary"
      @payment = Payment.create(price: t.price,
                                anniversary_id: t.anniversary_id,
                                tid: t.tid,
                                result_code: t.result_code,
                                payment_type: t.payment_type,
                                nickname: t.nickname,
                                bill_name: t.bill_name,
                                bill_address: t.bill_address,
                                bill_phone: t.bill_phone,
                                ssn: t.ssn,
                                buyeremail: t.buyeremail,
                                )
    end
    t.payment_id = @payment.id

    if t.save
      if t.result_code == "00"
        redirect_to @payment
      else
        @payment.add_fail_error
        render 'new'
      end
    else
      logger.info t.errors
      render 'new'
    end
  end

  def rnoti
    # inicis에서 넘어온 Parameter 저장하기
    # clientip = request.env["REMOTE_ADDR"]
    # if clientip == "211.219.96.165" or clientip == "118.129.210.25"
    t = Transaction.new

    p_noti = params["P_NOTI"].force_encoding("EUC-KR").encode("UTF-8").split(",")
    anniversary_id = p_noti[0].split("=")
    payment_type = p_noti[1].split("=")
    bill_name = p_noti[2].split("=")
    bill_phone = p_noti[3].split("=")
    bill_address = p_noti[4].split("=")
    ssn = p_noti[5].split("=")
    buyeremail = p_noti[6].split("=")
    helper_id = p_noti[7].split("=")

    t.tid = params[:P_TID]
    t.pay_at = params[:P_AUTH_DT]
    t.result_code = params[:P_STATUS]
    t.pay_method = params[:P_TYPE]
    t.moid = params[:P_OID]
    t.price = params[:P_AMT]
    t.nickname = params[:P_UNAME].force_encoding("EUC-KR").encode("UTF-8")
    t.result_msg = params[:P_RMESG1].force_encoding("EUC-KR").encode("UTF-8")
    t.p_rmesg2 = params[:P_RMESG2].force_encoding("EUC-KR").encode("UTF-8")
    t.anniversary_id = anniversary_id[1]
    t.payment_type = payment_type[1]
    t.bill_name = bill_name[1]
    t.bill_phone = bill_phone[1]
    t.bill_address = bill_address[1]
    t.ssn = ssn[1]
    t.buyeremail = buyeremail[1]
    t.helper_id = helper_id[1]

    t.save

    if payment_type[1] == "seedmoney"
      @payment = Payment.create(price: t.price,
                                anniversary_id: t.anniversary_id,
                                tid: t.tid,
                                result_code: t.result_code,
                                payment_type: t.payment_type,
                                nickname: t.nickname,
                                helper_id: t.helper_id)
      anniversary = Anniversary.unscoped.find(@payment.anniversary_id)
      anniversary.update(has_seedmoney_payment: true)
      user = @payment.anniversary.user
      user.update(role: "sponsor")
    elsif payment_type[1] == "temporary"
      @payment = Payment.create(price: t.price,
                                anniversary_id: t.anniversary_id,
                                tid: t.tid,
                                result_code: t.result_code,
                                payment_type: t.payment_type,
                                nickname: t.nickname,
                                bill_name: t.bill_name,
                                bill_address: t.bill_address,
                                bill_phone: t.bill_phone,
                                ssn: t.ssn,
                                helper_id: t.helper_id,
                                buyeremail: t.buyeremail)
    end
    t.payment_id = @payment.id

    if t.save
      if t.result_code == "00"
        redirect_to @payment
      else
        render nothing: true
      end
    else
      logger.info t.errors
      render 'new'
    end

    # mtrn.payment_id = p_noti["payment_id"]
    # mtrn.document_id = p_noti["document_id"]
    # mtrn.p_mid = params[:p_mid]
    # mtrn.p_status = params[:p_status]
    # mtrn.p_type = params[:p_type]
    # mtrn.p_auth_dt = params[:p_auth_dt]
    # mtrn.moid = params[:p_oid]
    # mtrn.p_fn_cd1 = params[:p_fn_cd1]
    # mtrn.p_fn_cd2 = params[:p_fn_cd2]
    # mtrn.p_fn_nm = params[:p_fn_nm]
    # mtrn.p_amt = params[:p_amt]
    # mtrn.p_uname = params[:p_uname]
    # mtrn.p_rmesg1 = params[:p_rmesg1]
    # mtrn.p_rmesg2 = params[:p_rmesg2]
    # mtrn.p_rmesg3 = params[:p_rmesg3]
    # mtrn.p_noti = params[:p_noti]
    # mtrn.p_auth_no = params[:p_auth_no]
    # mtrn.p_card_issuer_code = params[:p_card_issuer_code]
    # mtrn.p_card_num = params[:p_card_num]
    # mtrn.p_card_member_num = params[:p_card_member_num]
    # mtrn.p_card_purchase_code = params[:p_card_purchase_code]
    # mtrn.p_prtc_code = params[:p_prtc_code]
    # mtrn.created_at = params[:created_at]
    # mtrn.updated_at = params[:updated_at]

    # logger.info params.to_yaml
  end

  def result
    unless bank_helper = BankHelper.find(params[:helper_id])
      redirect_to anniversary_path(id: params[:anni_id])
    end
    @transaction = Transaction.where(helper_id: bank_helper.id).first
  end

  private

    def payment_params
      params.require(:payment).permit(:price, :anniversary_id)
    end
end