class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def hibernated
    @users = User.hibernated
  end
end