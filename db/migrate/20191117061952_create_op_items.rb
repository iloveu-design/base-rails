class CreateOpItems < ActiveRecord::Migration[5.2]
  def change
    create_table :op_items do |t|
      t.string :category
      t.integer :seq, default: 0
      t.json :content

      t.timestamps
    end
  end
end
