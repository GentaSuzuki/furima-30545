class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,          nill:false, foreign_key:true
      t.string     :name,        nill:false
      t.string     :tag
      t.text       :description,   nill:false
      t.integer    :category_id,   nill:false
      t.integer    :condition_id, nill:false
      t.integer    :postage_id,    nill:false
      t.integer    :prefecture_id, nill:false
      t.integer    :day_ship_id,   nill:false
      t.integer    :price,         nill:false
      t.timestamps
    end
  end
end
