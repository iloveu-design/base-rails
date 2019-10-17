class Admin::SubscriptionsController < AdminController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /admin/subscriptions
  # GET /admin/subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /admin/subscriptions/1
  # GET /admin/subscriptions/1.json
  def show
  end

  # DELETE /admin/subscriptions/1
  # DELETE /admin/subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to admin_subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end
end
