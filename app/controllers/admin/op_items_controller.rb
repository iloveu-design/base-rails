class Admin::OpItemsController < AdminController
  before_action :set_category, :get_setting, only: [:index]
  before_action :set_op_item, only: [:update, :destroy]

  def index
    @op_items = OpItem.where(category: @category)
  end

  def create
    @op_item = OpItem.new(op_item_params)
    @op_item.save
    redirect_to admin_op_items_path(category: @op_item.category)
  end

  def update
    @op_item.update(op_item_params)
    redirect_to admin_op_items_path(category: @op_item.category)
  end

  def destroy
    @op_item.destroy
  end

  private
    def set_category
      @category = params[:category]
    end

    def get_setting
      @op_item_setting = Setting.op_items[@category]
    end

    def set_op_item
      @op_item = OpItem.find(params[:id])
    end

    def op_item_params
      params.require(:op_item).permit(:category, :seq, content: {})
    end
end