class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @menus = Menu.all.order('created_at DESC')
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

  def show
    @menu_list = Menu.menu_list(@menu)
  end

  def edit
  end

  def update
    render :edit unless @menu.update(menu_params)
  end

  def destroy
    @menu.destroy
  end

  def search
    @menus = Menu.search(params[:keyword])
  end

  private

  def menu_params
    params.require(:menu).permit(:title, :amount, :unit, :calorie, :bar_code, images: [])
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
