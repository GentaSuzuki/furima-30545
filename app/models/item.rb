class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :day_ship
  belongs_to :user
  has_one    :order
  has_one_attached :image

  validates :image, presence: true
  validates :description, presence: true
  validates :name, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :postage_id, presence: true
  validates :prefecture_id, presence: true
  validates :day_ship_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 299, less_than: 10000000 }
  validates :category_id, numericality: { other_than: 0 }
  validates :condition_id, numericality: { other_than: 0 }
  validates :postage_id, numericality: { other_than: 0 }
  validates :prefecture_id, numericality: { other_than: 0 }
  validates :day_ship_id, numericality: { other_than: 0 }
end
