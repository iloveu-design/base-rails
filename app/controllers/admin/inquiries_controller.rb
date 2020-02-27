class Admin::InquiriesController < AdminController
  def index
    @inquiries = Inquiry.all

    @inquiries = @inquiries.search_for(params[:q]) if params[:q].present?
    @inquiries = @inquiries.page(params[:page])
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end
end
