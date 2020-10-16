  class OrderAddress
    include ActiveModel::Model
    attr_accessor  :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number,:item_id,:user_id


    def save
      # ユーザーの情報を保存し、「user」という変数に入れている
      order = Order.create(user_id: user_id, item_id: item_id)
      # 住所の情報を保存
      Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name,phone_number: phone_number, order_id: order.id)
    end
  end

