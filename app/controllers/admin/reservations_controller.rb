class Admin::ReservationsController < AdminController
  before_action :set_reservation, only: [:edit, :update, :destroy]
  def index
    @reservations = Reservation.order("id desc")
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to [:edit, :admin, @reservation], notice: I18n.t('msgs.saved')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to [:edit, :admin, @reservation], notice: I18n.t('msgs.saved')
    else
      render :edit
    end
  end

  def destroy
  end

  private

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def reservation_params
      params.require(:reservation).permit(:name, :body, :start_on, :end_on)
    end
end