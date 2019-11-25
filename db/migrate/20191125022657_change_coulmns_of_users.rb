class ChangeCoulmnsOfUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :hiberante_notified_at, :hibernate_notified_at
  end
end
