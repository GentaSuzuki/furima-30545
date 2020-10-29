class ItemsTag

  include ActiveModel::Model
  attr_accessor :tag, :tag_name

  with_options presence: true do
    validates :tag
    validates :tag_name
  end

  def save
    item = Item.create(tag: tag)
    tag = Tag.where(teg_name: tag_name).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

end