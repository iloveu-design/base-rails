class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.belongs_to :space
      t.string :name
      t.string :body
      t.datetime :start_on
      t.datetime :end_on

      t.timestamps
    end
  end
end
