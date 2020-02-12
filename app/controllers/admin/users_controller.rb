class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def hibernated
    @users = User.hibernated
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end
end