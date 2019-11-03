class Admin::SpacesController < AdminController
  before_action :set_space

  def index
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
      @space = Space.first || Space.create(name: '슬로워크홀')
    end

    def space_params
      params.require(:space).permit(
        :image, :phone, :email, :time, :seats, :price, :min_time, :advantages, :manager, :precautions, events: [], cafes: [], usages: []
      )
    end
end