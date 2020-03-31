class ChangePolicyBodyToMediumText < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        change_column :policies, :body, :mediumtext
      end
      dir.down do
        change_column :policies, :body, :text
      end
    end
  end
end
