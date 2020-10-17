  class OrderAddress
    include ActiveModel::Model
    attr_accessor  :post_code, :prefecture_id, :city, :house_number, :build_number, :phone_number,:item_id,:user_id,:token

    validates :token,:post_code,:prefecture_id,:city,:house_number,:phone_number, presence: true
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :post_code,format:{with: /\A\d{3}[-]\d{4}\z/}
    validates :phone_number, format:{with: /\A\d{11}\z/}


    def save
      # ユーザーの情報を保存し、「order」という変数に入れている
      order = Order.create(user_id: user_id, item_id: item_id)
      # 住所の情報を保存
      Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number, build_number: build_number, phone_number: phone_number, order_id: order.id)
    end
  end

