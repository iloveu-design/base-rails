class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    create_table :board_categories do |t|
      t.belongs_to :board

      t.integer :seq
      t.string :name
      t.string :slug
      t.string :ancestry

      t.timestamps
    end

    create_table :board_posts do |t|
      t.belongs_to :user
      t.belongs_to :board
      t.belongs_to :board_category

      t.string :title
      t.text :body

      t.timestamps
    end

    add_index :boards, :slug, unique: true
    add_index :board_categories, :slug, unique: true
    add_index :board_categories, :ancestry
  end
end
