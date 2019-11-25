module PaymentsHelper
  def getPayResult(code)
    case code
      when "00"
        rtn_message = "결제완료"
      when "01"
        rtn_message = "오류"
      else
        rtn_message = ""
    end

    rtn_message
  end

  # inicis결제 코드값 가져오기
  def getPaymentCodeTitle(colname, code)
    rtnTitle = ""

    case colname
      when "transaction.result_code"
        codehash = { "00" => "성공", "01" => "결제오류" }
      when "transaction.pay_method"
        codehash = { "VCard" => "신용카드(ISP)", "Card" => "신용카드(안심클릭)", "DirectBank" => "실시간계좌이체", "HPP" => "핸드폰", "VBank" => "무통장입금(가상계좌)" }
      when "transaction.card"
        codehash = { "01"=>"외환", "03"=>"롯데", "04"=>"현대", "06"=>"국민", "11"=>"BC", "12"=>"삼성", "14"=>"신한", "15"=>"한미",
          "16"=>"NH", "17"=>"하나 SK", "21"=>"해외비자", "22"=>"해외마스터", "23"=>"JCB", "24"=>"해외아멕스", "25"=>"해외다이너스" }
      when "transaction.bank_code"
        codehash = { "03"=>"기업", "04"=>"국민", "05"=>"외환", "07"=>"수협중앙회", "11"=>"농협중앙회", "20"=>"우리은행", "23"=>"SC제일은행", "31"=>"대구은행",
          "32"=>"부산은행", "34"=>"광주은행", "37"=>"전북은행", "39"=>"경남은행", "53"=>"한국씨티은행", "71"=>"우체국", "81"=>"하나은행", "88"=>"신한은행" }
      when "mtransaction.p_status"
        codehash = { "00" => "성공", "01" => "결제오류" }
      when "mtransaction.p_type"
        codehash = { "ISP" => "신용카드 ISP", "CARD" => "신용카드 안심클릭", "VBANK" => "가상계좌", "BANK" => "계좌이체" }
      else
        codehash = { code => code }
    end

    rtnTitle = codehash[code]
    rtnTitle
  end
end