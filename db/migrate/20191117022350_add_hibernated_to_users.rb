class AddHibernatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hibernated, :boolean, default: false
    add_column :users, :hiberante_notified_at, :datetime
  end
end
