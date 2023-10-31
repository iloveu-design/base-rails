class SubscriptionsController < ApplicationController
  before_action :set_model, only: [:show]

  def show

  end

  def create
    @subscription = Subscription.new(model_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_model
    end

    def model_params
      params.require(:subscription).permit(:name, :email)
    end
end