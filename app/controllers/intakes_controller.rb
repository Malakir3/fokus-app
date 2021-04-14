class IntakesController < ApplicationController
  before_action :set_intake, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:show, :edit, :update, :destroy]

  def index
    @intakes = Intake.includes(:menu).where(user_id: current_user.id).order('date DESC').order('timing_id DESC')
    set_standards
    Graph.destroy_graph(Graph.all)
  end

  def new
    @intake = Intake.new
    @menu = Menu.find(params[:menu_id])
  end

  def create
    @intake = Intake.new(intake_params)
    return @menus = Menu.all.order('created_at DESC') if @intake.save

    @menu = Menu.find(params[:menu_id])
    render :new
  end

  def show
    set_standards
  end

  def edit
    @menu = @intake.menu
  end

  def update
    return if @intake.update(intake_params)

    @menu = @intake.menu
    render :edit
  end

  def destroy
    @intake.destroy
  end

  private

  def intake_params
    params.require(:intake).permit(
      :date, :timing_id, :value_id
    ).merge(user_id: current_user.id, menu_id: params[:menu_id])
  end

  def set_intake
    @intake = Intake.find(params[:id])
  end

  def set_standards
    @standards = Standard.includes(:menu).where(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless @intake.user_id == current_user.id
  end
end
