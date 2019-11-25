class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer  "price"
      t.string   "payment_type"
      t.string   "tid"
      t.string   "result_code"
      t.string   "nickname"
      t.integer  "product_id"
      t.string   "bill_name"
      t.string   "bill_phone"
      t.string   "bill_address"
      t.string   "encrypted_ssn"
      t.string   "encrypted_ssn_salt"
      t.string   "encrypted_ssn_iv"
      t.boolean  "is_cancel", default: false
      t.string   "buyeremail"

      t.timestamps
    end
  end
end
