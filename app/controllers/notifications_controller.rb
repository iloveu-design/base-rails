class NotificationsController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @notifications = @user.notifications
  end

  def show
    @notification = Notification.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end