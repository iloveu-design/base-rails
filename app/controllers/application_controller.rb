class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      added_attrs = [:email, :password, :password_confirmation, :name, :remember_me,
                    :terms_and_conditions, :privacy_policy]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs.push(:role, :login)
      devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    def current_ability
      # I am sure there is a slicker way to capture the controller namespace
      controller_name_segments = params[:controller].split('/')
      controller_name_segments.pop
      controller_namespace = controller_name_segments.join('/').camelize
      Ability.new(current_user, controller_namespace)
    end
end
