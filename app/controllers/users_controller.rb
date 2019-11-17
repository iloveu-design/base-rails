class UsersController < ApplicationController
  before_action :set_member, only: [:follow, :unfollow]

  def index
    @users = User.all
  end

  def follow
    current_user.follow!(@user) unless current_user.following?(@user)
  end

  def unfollow
    current_user.unfollow!(@user)
  end

  private

  def set_member
    @user = User.find(params[:id])
  end
end