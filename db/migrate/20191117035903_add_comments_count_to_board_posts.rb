class AddCommentsCountToBoardPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :board_posts, :comments_count, :integer, default: 0
  end
end
