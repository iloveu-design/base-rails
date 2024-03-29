class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string   "tid"
      t.string   "result_code"
      t.string   "result_msg"
      t.string   "pay_method"
      t.string   "moid"
      t.string   "price"
      t.string   "pay_at"
      t.string   "card_approve_num"
      t.string   "card_quota"
      t.string   "card_interest"
      t.string   "card_code"
      t.string   "card_bank_code"
      t.string   "card_auth_type"
      t.string   "card_event_code"
      t.string   "acct_bank_code"
      t.string   "cshr_result_code"
      t.string   "cshr_type"
      t.string   "vact_reg_num"
      t.string   "vact_num"
      t.string   "vact_bank_code"
      t.string   "vact_date"
      t.string   "vact_input_name"
      t.string   "vact_name"
      t.string   "payment_id"
      t.string   "anniversary_id"
      t.string   "nickname"
      t.string   "payment_type"
      t.string   "p_card_issuer_code"
      t.string   "p_card_num"
      t.string   "p_card_member_num"
      t.string   "p_card_purchase_code"
      t.string   "p_card_prtc_code"
      t.string   "p_vact_time"
      t.string   "p_auth_no"
      t.string   "p_rmesg2"
      t.string   "p_noti"
      t.string   "bill_name"
      t.string   "bill_phone"
      t.string   "bill_address"
      t.string   "ssn"
      t.integer  "helper_id"
      t.string   "buyeremail"

      t.timestamps
    end
  end
end
