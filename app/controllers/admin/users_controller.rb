class Admin::UsersController < AdminController
  def index
    @users = User.all

    @users = @users.search_for(params[:q]) if params[:q].present?

    if params[:format] == 'xlsx'
      render xlsx: 'index.xlsx.axlsx', filename: "회원_#{Date.current.strftime('%Y%m%d')}"
    else
      @users = @users.page(params[:page])
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def hibernated
    @users = User.hibernated
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end
end