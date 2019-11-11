class Admin::BoardsController < AdminController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  def index
    @boards = Board.all
  end

  def new
    @board = Board.new
  end

  def edit
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      redirect_to edit_admin_board_path(@board), notice: I18n.t('msgs.success.saved')
    else
      render :new
    end
  end

  def update
    if @board.update(board_params)
      redirect_to edit_admin_board_path(@board), notice: I18n.t('msgs.success.saved')
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to admin_boards_path, notice: I18n.t('msgs.success.destroyed')
  end

  private

    def set_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(
        :name, :slug,
        categories_attributes: [:id, :seq, :name, :slug, :_destroy],
      )
    end
end