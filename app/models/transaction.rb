class Transaction < ApplicationRecord
  # attr_accessor :tid, :payment_id, :result_code, :result_msg, :pay_method, :moid, :price, :pay_at, :card_approve_num, :card_quota, :card_interest, :card_code, :card_bank_code, :card_auth_type, :card_event_code, :acct_bank_code, :cshr_result_code, :cshr_type, :vact_reg_num, :vact_num, :vact_bank_code, :vact_date, :vact_input_name, :vact_name

  # relations
  belongs_to :payment

  # validations
  validates :tid, uniqueness: true

  # class methods
  def self.build_transaction(params)
    result = Inicis.secure_pay(params)
    logger.info result.to_yaml
    self.create(result)
  end

  def self.build_transaction_mobile(params)
    result = Inicis.secure_pay_mobile(params)
    logger.info result.to_yaml
    self.create(result)
  end

  def cancel!
    if is_vbank?
      self.update_attributes(refund: true)
      return true
    else
      result = Inicis.secure_cancel(tid: self.tid, msg: "cancel")
      logger.info result.to_yaml
      self.update_attributes(result)

      if (result[:cancel_result_code] == "00") || (result[:cancel_result_msg].include? "기 취소 거래")
        self.update_attributes(refund: true)
      else
        return false
      end
    end
  end

  def success?
    self.result_code == "00"
  end

  def is_vbank?
    self.pay_method == 'VBank'
  end

  def is_direct_bank?
    self.pay_method == 'DirectBank'
  end

  def is_card?
    self.pay_method == 'Card' || self.pay_method == 'VCard'
  end

  def vbank_name
    Inicis.bank_codes[self.vact_bank_code]
  end
end
