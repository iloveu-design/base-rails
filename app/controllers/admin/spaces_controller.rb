class Admin::SpacesController < AdminController
  before_action :set_space, only: [:show, :edit, :update, :delete_file]

  def index
    @spaces = Space.all
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    if @space.save
      redirect_to admin_space_path(@space), notice: I18n.t("msgs.success.saved")
    else
      render :new
    end
  end

  def show
    redirect_to edit_admin_space_path(@space)
  end

  def edit
  end

  def update
    @space.update(space_params)
    redirect_to admin_spaces_url
  end

  def delete_file
    @file_id = params[:file_id]
    @type = params[:type]

    if @type == 'image'
      @space.image.delete
    else
      @space.try(@type).find(@file_id).delete
    end
  end

  private

    def set_space
      @space = Space.find(params[:id])
    end

    def space_params
      params.require(:space).permit(
        :name, :image, :phone, :email, :time, :seats, :price, :min_time, :advantages, :manager, :precautions, events: [], cafes: [], usages: []
      )
    end
end