class InquiriesController < ApplicationController
  before_action :authenticate_user!

  def new
    @inquiry = Inquiry.new
  end

  def show
    @inquiry = current_user.inquiries.find(params[:id])
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.user = current_user

    respond_to do |format|
      if @inquiry.save
        format.html
        format.json { render :show, status: :created, location: @inquiry }
      else
        format.html { render :new }
        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def inquiry_params
      params.require(:inquiry).permit(:title, :body)
    end
end
