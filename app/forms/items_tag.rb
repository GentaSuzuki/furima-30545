class ItemsTag

  include ActiveModel::Model
  attr_accessor :tag_name,:name,:description,:images,:category_id,:condition_id,:postage_id,:prefecture_id,:day_ship_id,:price,:user_id

  with_options presence: true do
    validates :tag_name
    validates :description
    validates :name
    validates :category_id
    validates :condition_id
    validates :postage_id
    validates :prefecture_id
    validates :day_ship_id
    validates :price, numericality: { greater_than: 299, less_than: 10_000_000 }
    validates :category_id, numericality: { other_than: 0,message:'---以外を選択してください' }
    validates :condition_id, numericality: { other_than: 0,message:'---以外を選択してください' }
    validates :postage_id, numericality: { other_than: 0,message:'---以外を選択してください' }
    validates :prefecture_id, numericality: { other_than: 0, message:'---以外を選択してください'}
    validates :day_ship_id, numericality: { other_than: 0, message:'---以外を選択してください' }
  end

  def save
    item = Item.create(name: name,description: description, category_id: category_id, condition_id: condition_id, postage_id: postage_id, prefecture_id: prefecture_id, day_ship_id: day_ship_id, price: price, user_id:user_id,images:images)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

end