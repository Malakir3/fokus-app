class StandardsController < ApplicationController
  before_action :set_standard, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:show, :edit, :update, :destroy]

  def index
    @standards = Standard.includes(:menu).where(user_id: current_user.id)
    @menus = Menu.all
    @cal_results = Standard.calorie_cal(@standards) unless @standards == []
  end

  def new
    @standard = Standard.new
    set_menu
    @amount_cal = Standard.amount_cal(@menu)
  end

  def create
    if params[:standard] == nil
      redirect_to new_menu_standard_path
    else
      @standard = Standard.new(standard_params)
      if @standard.valid?
        Standard.create(standard_params)
      else
        set_menu
        @amount_cal = Standard.amount_cal(@menu)
        render :new
      end
    end
  end

  def show
    @cal_result = Standard.calorie_cal(@standard)
  end

  def edit
    @menu = @standard.menu
    @amount_cal = Standard.amount_cal(@menu)
  end

  def update
    unless @standard.update(standard_params)
      @menu = @standard.menu
      render :edit 
    end
  end

  def destroy
    @standard.destroy
  end

  private

  def standard_params
    params.require(:standard).permit(:large, :medium, :small).merge(user_id: current_user.id, menu_id: params[:menu_id])
  end

  def set_menu
    @menu = Menu.find(params[:menu_id])
  end

  def set_standard
    @standard = Standard.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless @standard.user_id == current_user.id
  end
end
