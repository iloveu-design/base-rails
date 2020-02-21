class Admin::PoliciesController < AdminController
  before_action :set_policy, only: [:edit, :update, :destroy]
  before_action :set_category, only: [:index, :new]

  def index
    @policies = Policy.where(category: params[:category]).order("id desc")
  end

  def new
    @policy = Policy.new(category: @category)
  end

  def edit
  end

  def create
    @policy = Policy.new(policy_params)

    if @policy.save
      redirect_to [:edit, :admin, @policy], notice: I18n.t('msgs.success.saved')
    else
      render :new
    end
  end

  def update
    if @policy.update(policy_params)
      redirect_to [:edit, :admin, @policy], notice: I18n.t('msgs.success.saved')
    else
      render :edit
    end
  end

  def destroy
    @policy.destroy
    redirect_to admin_policies_path(category: @policy.category)
  end

  private
    def set_policy
      @policy = Policy.find(params[:id])
    end

    def set_category
      @category = params[:category]
      @category_name = Policy.category_name(params[:category])
    end

    def policy_params
      params.require(:policy).permit(:category, :body)
    end
end