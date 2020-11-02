class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :item_find, only: [:edit, :update, :destroy]
  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item =ItemsTag.new
  end

  def create
    @item = ItemsTag.new(item_params)
    if @item.valid?
       @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    return redirect_to root_path if current_user.id != @item.user_id
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
  @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def item_params
    params.require(:items_tag).permit(:name, :description, :image, :category_id, :condition_id, :postage_id, :prefecture_id, :day_ship_id, :price,:tag_name).merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

end
