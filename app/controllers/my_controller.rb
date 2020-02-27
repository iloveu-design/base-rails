class MyController < ApplicationController
  before_action :authenticate_user!

  def inquiries
    @inquiries = current_user.inquiries.page(params[:page])
  end
end
