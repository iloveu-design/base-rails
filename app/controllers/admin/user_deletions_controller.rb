class Admin::UserDeletionsController < AdminController
  def index
    @user_deletions = UserDeletion.all

    @user_deletions = @user_deletions.page(params[:page])
  end
end
