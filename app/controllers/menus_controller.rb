class MenusController < ApplicationController
  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.valid?
      Menu.create(menu_params)
    else
      render :new
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:title, :amount, :unit, :calorie, :bar_code)
  end
end
