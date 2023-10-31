class Admin::BoardPosts::CommentsController < Admin::CommentsController
  before_action :set_commentable

  private

    def set_commentable
      @commentable = Board::Post.find(params[:board_post_id])
    end
end
