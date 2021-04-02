class StandardsController < ApplicationController

  def index
    @standards = Standard.includes(:menu).where(user_id: current_user.id)
    @menus = Menu.all
    @cal_results = Standard.calorie_cal(@standards)
  end

  def new
    @standard = Standard.new
    @menu = Menu.find(params[:menu_id])
  end

  def create
    @standard = Standard.new(standard_params)
    if @standard.valid?
      Standard.create(standard_params)
    else
      @menu = Menu.find(params[:menu_id])
      render :new
    end
  end

  def show
    @standard = Standard.find(params[:id])
  end

  def edit
    @standard = Standard.find(params[:id])
    @menu = @standard.menu
  end

  def update
    @standard = Standard.find(params[:id])
    unless @standard.update(standard_params)
      @menu = @standard.menu
      render :edit 
    end
  end

  def destroy
    @standard = Standard.find(params[:id])
    @standard.destroy
  end

  private

  def standard_params
    params.require(:standard).permit(:large, :medium, :small).merge(user_id: current_user.id, menu_id: params[:menu_id])
  end
end
