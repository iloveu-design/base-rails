class Admin::ReservationsController < AdminController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  def index
    @reservations = Reservation.all

    @reservations = @reservations.where(space: params[:space_id]) if params[:space_id].present?
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to [:edit, :admin, @reservation], notice: I18n.t('msgs.success.saved')
    else
      render :new
    end
  end

  def show
    redirect_to edit_admin_reservation_path(@reservation)
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to [:edit, :admin, @reservation], notice: I18n.t('msgs.success.saved')
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to admin_reservations_path, notice: I18n.t('msgs.success.destroyed')
  end

  private

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:space_id, :name, :body, :start_on, :end_on)
    end
end