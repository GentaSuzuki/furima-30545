class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_root
  before_action :buy_check
  before_action :params_item_id
  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      buy_key
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :house_number, :build_number, :phone_number, :token).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user.id
  end

  def buy_check
    @item = Item.find(params[:item_id])
    redirect_to root_path if !@item.order.nil? && @item.id == @item.order.item_id
  end

  def params_item_id
    @item = Item.find(params[:item_id])
  end

  def buy_key
    Payjp.api_key = 'sk_test_eb1ebc90a4743adefb512848'  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,
        card: order_address_params[:token],
        currency: 'jpy'
      )
    end
end
