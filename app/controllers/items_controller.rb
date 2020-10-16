class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :item_find, only: [:edit,:update]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
     if user_signed_in? && current_user.id == @item.user_id
      render :edit
     else
      render :new
     end
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to root_path
    else
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :category_id, :condition_id, :postage_id, :prefecture_id, :day_ship_id, :price).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end
end
