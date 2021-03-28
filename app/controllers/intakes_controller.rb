class IntakesController < ApplicationController

  def index
    @intakes = Intake.includes(:menu)
  end

  def new
    @intake = Intake.new
    @menu = Menu.find(params[:menu_id])

    # ↓後で編集する。すでに基準が登録されている場合は編集ページにリダイレクト。
    # unless Intake.where(user_id: current_user.id, menu_id: @menu.id) == []
    #   redirect_to action: :edit
    # end
  end

  def create
    @intake = Intake.new(intake_params)
    unless @intake.save
      @menu = Menu.find(params[:menu_id])
      render :new
    end
  end

  def show
    @intake = Intake.find(params[:id])
  end

  def edit
    @intake = Intake.find(params[:id])
    @menu = @intake.menu
  end

  def update
    @intake = Intake.find(params[:id])
    unless @intake.update(intake_params)
      @menu = @intake.menu
      render :edit 
    end
  end

  def destroy
    @intake = intake.find(params[:id])
    @intake.destroy
  end

  private

  def intake_params
    params.require(:intake).permit(:date, :timing_id, :value_id).merge(user_id: current_user.id, menu_id: params[:menu_id])
  end
end
