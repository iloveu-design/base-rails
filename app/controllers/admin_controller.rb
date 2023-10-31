class AdminController < ApplicationController
  before_action :require_admin
  authorize_resource
  layout 'admin'

  def require_admin
    unless (current_user && (current_user.super_admin? || current_user.admin?))
      redirect_to '/', alert: '이페이지는 존재하지 않습니다.'
    end
  end
end