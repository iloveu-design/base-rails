class Admin::PaymentsController < AdminController
  def edit_cancel_status
    payment = Payment.find params[:payment_id]
    payment.is_cancel = !(payment.is_cancel)
    payment.save

    redirect_to admin_user_path(User.find(params[:user_id]))
  end

  def index
    if params[:filter].present?
      @payments = Payment.where(payment_type: params[:filter]).order('created_at DESC').page(params[:page]).per(10)
    end
  end
end