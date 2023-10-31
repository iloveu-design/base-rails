class Admin::SettingsController < AdminController
  before_action :get_setting, only: [:edit, :update]

  def create
    setting_params.keys.each do |key|
      Setting.send("#{key}=", setting_params[key].strip) unless setting_params[key].nil?
    end
    redirect_to admin_settings_path, notice: I18n.t('msgs.success.saved')
  end

  private

    def setting_params
      params.require(:setting).permit(:site_name, :host, :user_limits, :admin_emails,
        :captcha_enable, :notification_options, :op_items)
    end
end