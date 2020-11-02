class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day_ship
  belongs_to :user
  has_one    :order
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
  has_many_attached :images

  validates :images, presence: true
  validates :description, presence: true
  validates :name, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :postage_id, presence: true
  validates :prefecture_id, presence: true
  validates :day_ship_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 299, less_than: 10_000_000 }
  validates :category_id, numericality: { other_than: 0,message:'---以外を選択してください' }
  validates :condition_id, numericality: { other_than: 0,message:'---以外を選択してください' }
  validates :postage_id, numericality: { other_than: 0,message:'---以外を選択してください' }
  validates :prefecture_id, numericality: { other_than: 0, message:'---以外を選択してください'}
  validates :day_ship_id, numericality: { other_than: 0, message:'---以外を選択してください' }

end
