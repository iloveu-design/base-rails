class MyController < ApplicationController
  before_action :authenticate_user!

  def inquiries
    @inquiries = current_user.inquiries.recent.page(params[:page])
  end
end
