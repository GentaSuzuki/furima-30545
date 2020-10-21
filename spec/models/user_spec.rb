require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname,last_name,first_name,last_name_kana,first_name_kana,email,password,encrypted_password,birth_dateが存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailに@がない場合はできないこと' do
      @user.email = 'suzukigmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'emailが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが六文字以上であれば登録できること' do
      @user.password = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは、数字のみの入力ができない' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Input half-width characters.')
    end

    it 'パスワードは、英字のみの場合登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Input half-width characters.')
    end

    it 'passwordが存在してもencrypted_passwordが空では登録できないこと' do
      @user.encrypted_password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Encrypted password can't be blank")
    end

    it 'パスワードとパスワード(確認用)、値が一致が必須であること' do
      @user.password = '123456' == @user.encrypted_password = '123467'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'last_nameが必須であること' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'last_nameが全角日本語であること' do
      @user.last_name = 'suzuki'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
    end

    it 'first_nameが必須であること' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'first_nameが全角日本語であること' do
      @user.first_name = 'genta'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
    end

    it 'last_name_kanaが必須であること' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'last_name_kanaがカタカナ以外だと登録できないこと' do
      @user.last_name_kana = 'sず木'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
    end

    it 'first_name_kanaが必須であること' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'first_name_kanaがカタカナ以外だと登録できないこと' do
      @user.first_name_kana = 'gん太'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
    end

    it 'birth_dateが必須であること' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
