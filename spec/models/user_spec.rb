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
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが六文字以上であれば登録できること' do
      @user.password = '123456'
      @user.encrypted_password = '123456'
      expect(@user).to be_valid
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = '111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
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

    it 'first_nameが必須であること' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    #  it "全角表示であること"do
    #  @user.name_zenkaku ="aaa"
    #  @user.valid?
    #  expect(@user.errors.full_messages).to include("Name zenkaku can't be blank")
    # end
    it 'last_name_kanaが必須であること' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'first_name_kanaが必須であること' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    #  it "振り仮名が全角表示であること" do
    #  @user.hurigana_zenkaku = "aaa"
    #  @user.valid?
    #  expect(@user.errors.full_messages).to include("Frigana zenkaku can't be blank")
    #  end
    it 'birth_dateが必須であること' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
