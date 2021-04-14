class MenusController < ApplicationController
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
    @menu = Menu.find(params[:id])
    @menu_list = Menu.menu_list(@menu)
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    render :edit unless @menu.update(menu_params)
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
  end

  def search
    @menus = Menu.search(params[:keyword])
  end

  private

  def menu_params
    params.require(:menu).permit(:title, :amount, :unit, :calorie, :bar_code, images: [])
  end
end
