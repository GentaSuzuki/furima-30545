require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it 'image,name,description,category_id,condition_id,postage_id,referense_id,day_ship,priceがあれば保存できる' do
      expect(@item).to be_valid
    end

    it '商品画像が一枚つけることが必須であること' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("画像を入力してください")
    end

    it '商品名が必須であること' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end

    it '商品の説明が必須であること' do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("商品説明を入力してください")
    end

    it 'カテゴリーの情報が必須であること' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('カテゴリーは0以外の値にしてください')
    end

    it '商品の状態についての情報が必須であること' do
      @item.condition_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('商品の状態は0以外の値にしてください')
    end

    it '配送料の負担について情報があること' do
      @item.postage_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('配送料の負担は0以外の値にしてください')
    end

    it '発送元の地域についての情報があること' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('発送元の地域は0以外の値にしてください')
    end

    it '発送までの日数についての情報が必須であること' do
      @item.day_ship_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('発送までの日数は0以外の値にしてください')
    end

    it '価格についての情報が必須であること' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("金額を入力してください")
    end

    it '価格の範囲¥300以上の範囲であること' do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include('金額は299より大きい値にしてください')
    end

    it '価格の範囲が¥9,999,999以下であること' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('金額は10000000より小さい値にしてください')
    end
  end
end
