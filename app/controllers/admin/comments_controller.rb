class Admin::CommentsController < AdminController
  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    @comment.save
    redirect_to [:admin, @commentable], notice: I18n.t('msgs.success.saved')
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to [:admin, @commentable], notice: I18n.t('msgs.success.destroyed')
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
