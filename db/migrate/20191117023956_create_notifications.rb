class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.integer :ntype
      t.string :sender
      t.string :title
      t.string :body
      t.string :url
      t.string :extra
      t.datetime :read_at

      t.timestamps
    end
  end
end
