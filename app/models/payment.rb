class Payment < ApplicationRecord
  attr_encrypted :ssn, :key => 'secret key', :mode => :per_attribute_iv_and_salt

  # belongs_to :product
  has_many :transactions

  validates :tid, uniqueness: true
  validates :price, :tid, :result_code, :nickname, :payment_type, presence: true
  validate :check_validate_price

  scope :except_cancel, -> { where("is_cancel IS NULL OR is_cancel = ?", false)}
  scope :temporary, -> { where(payment_type: 'temporary') }
  scope :seedmoney, -> { where(payment_type: 'seedmoney') }

  def check_validate_price
    if payment_type == "seedmoney" && price != Anniversary.unscoped.find(anniversary_id).contribution
      errors.add(:base, "결제 금액이 올바르지 않습니다. 관리자에게 문의하세요.")
    end
  end

  def add_fail_error
    errors.add(:base, "결제에 실패했습니다. 결제정보를 다시 확인해주세요.")
  end
end
