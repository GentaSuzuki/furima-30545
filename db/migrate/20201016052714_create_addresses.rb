class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :post_code,           nill:false
      t.integer :prefecture_id,   nill:false,foreign_key:true
      t.string :city,                nill:false
      t.string :house_number,        nill:false
      t.string :build_number,        nill:false
      t.string :phone_number,        nill:false
      t.references :order,           nill:false,foreign_key:true
      t.timestamps
    end
  end
end
