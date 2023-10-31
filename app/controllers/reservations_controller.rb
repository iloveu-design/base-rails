class ReservationsController < ApplicationController
  def index
    @start_on = params[:start_on].present? ? params[:start_on].to_date : Date.current.beginning_of_week
    @weekdays = [@start_on]
    6.times do
      @weekdays << @weekdays.last.tomorrow
    end
    @reservations = Reservation.between_times(@weekdays.first, @weekdays.last, field: :start_on)

    respond_to do |format|
      format.html
      format.js
    end
  end
end