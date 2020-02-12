class Admin::RolesController < AdminController
  def index
    @users = User.all
    @users = @users.where(role: params[:role]) if params[:role].present?
  end
end