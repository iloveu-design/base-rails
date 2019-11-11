class Admin::BoardPostsController < AdminController
  before_action :set_board_post, only: [:show, :edit, :update, :destroy]
  def index
    @board_posts = Board::Post.all

    if params[:board].present?
      @board_posts = @board_posts.where(board_id: params[:board])
    end
  end

  def new
    @board_post = Board::Post.new
  end

  def edit
  end

  def create
    @board_post = Board::Post.new(board_post_params)

    if @board_post.save
      redirect_to edit_admin_board_post_path(@board_post), notice: I18n.t('msgs.success.saved')
    else
      render :new
    end
  end

  def update
    if @board_post.update(board_post_params)
      redirect_to edit_admin_board_post_path(@board_post), notice: I18n.t('msgs.success.saved')
    else
      render :edit
    end
  end

  def destroy
    @board_post.destroy
    redirect_to admin_board_posts_path, notice: I18n.t('msgs.success.destroyed')
  end

  private

    def set_board_post
      @board_post = Board::Post.find(params[:id])
    end

    def board_post_params
      params.require(:board_post).permit(
        :board_id, :title, :body
      )
    end
end