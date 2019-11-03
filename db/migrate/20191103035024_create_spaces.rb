class CreateSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :time
      t.string :seats
      t.text :price
      t.string :min_time
      t.text :advantages
      t.string :manager
      t.string :precautions

      t.timestamps
    end
  end
end
