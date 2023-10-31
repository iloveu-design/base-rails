class SpacesController < ApplicationController
  def index
    @spaces = Space.all

    @spaces = @spaces.search_for(params[:q]) if params[:q].present?
  end

  def show
    @space = Space.find(params[:id])
  end
end