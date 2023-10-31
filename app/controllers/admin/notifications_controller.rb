class Admin::NotificationsController < AdminController
  def index
    @notifications = Notification.all
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to admin_notifications_path, notice: I18n.t('msgs.success.destroyed')
  end
end