require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '#create' do
    before do
      @address = FactoryBot.build(:order_address)
    end

    it 'tokenとpost_codeとprefectureとcityとhouse_numberとphone_number' do
      expect(@address).to be_valid
    end

    it '郵便番号が必須であること' do
      @address.post_code = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Post code can't be blank")
    end

    it '郵便番号には「-」が必要なこと' do
      @address.post_code = '4210101'
      @address.valid?
      expect(@address.errors.full_messages).to include('Post code is invalid')
    end

    it '都道府県が必須であること' do
      @address.prefecture_id = 0
      @address.valid?
      expect(@address.errors.full_messages).to include('Prefecture must be other than 0')
    end

    it '市区町村が必須であること' do
      @address.city = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("City can't be blank")
    end

    it '番地があること' do
      @address.house_number = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("House number can't be blank")
    end

    it '電話番号が必須であること' do
      @address.phone_number = nil
      @address.valid?
      expect(@address.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号は１１桁であること' do
      @address.phone_number = '000111222'
      @address.valid?
      expect(@address.errors.full_messages).to include('Phone number is invalid')
    end
    
    it '電話番号にハイフンがある場合は購入できない'do
    @address.phone_number = '090-1010-2020'
    @address.valid?
    expect(@address.errors.full_messages).to include('Phone number is invalid')
  end
  end
end
