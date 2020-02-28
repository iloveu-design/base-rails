class ApplicationController < ActionController::Base
  protected
    def current_ability
      # I am sure there is a slicker way to capture the controller namespace
      controller_name_segments = params[:controller].split('/')
      controller_name_segments.pop
      controller_namespace = controller_name_segments.join('/').camelize
      Ability.new(current_user, controller_namespace)
    end
end
