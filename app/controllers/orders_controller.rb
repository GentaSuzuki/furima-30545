class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :move_to_root
  before_action :buy_check
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      Payjp.api_key = "sk_test_eb1ebc90a4743adefb512848"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,
        card: order_address_params[:token],
        currency: 'jpy'
      )
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(:post_code,:prefecture_id,:city,:house_number,:build_number,:phone_number,:token).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def move_to_root
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user.id
      redirect_to root_path
    end
  end
   def buy_check
    @item = Item.find(params[:item_id])
    if !@item.order.nil? && @item.id == @item.order.item_id
      redirect_to root_path
    end
  end
end
