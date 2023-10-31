class CreateUserDeletions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_deletions do |t|
      t.string :reason

      t.timestamps
    end
  end
end
