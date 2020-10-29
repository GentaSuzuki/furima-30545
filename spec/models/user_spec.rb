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
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it 'emailが空では登録できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it 'emailに@がない場合はできないこと' do
      @user.email = 'suzukigmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'emailが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end

    it 'passwordが六文字以上であれば登録できること' do
      @user.password = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end

    it 'パスワードは、数字のみの入力ができない' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
    end

    it 'パスワードは、英字のみの場合登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは半角英数字混合で入力してください')
    end

    it 'passwordが存在してもencrypted_passwordが空では登録できないこと' do
      @user.encrypted_password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("暗号化パスワード確認用パスワードを入力してください")
    end

    it 'パスワードとパスワード(確認用)、値が一致が必須であること' do
      @user.password = '123456' == @user.encrypted_password = '123467'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end

    it 'last_nameが必須であること' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください")
    end

    it 'last_nameが全角日本語であること' do
      @user.last_name = 'suzuki'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字を全角で入力してください')
    end

    it 'first_nameが必須であること' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください")
    end

    it 'first_nameが全角日本語であること' do
      @user.first_name = 'genta'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前を全角で入力してください')
    end

    it 'last_name_kanaが必須であること' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("フリガナ(苗字)を入力してください")
    end

    it 'last_name_kanaがカタカナ以外だと登録できないこと' do
      @user.last_name_kana = 'sず木'
      @user.valid?
      expect(@user.errors.full_messages).to include("フリガナ(苗字)を全角で入力してださい")
    end

    it 'first_name_kanaが必須であること' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("フリガナ(名前)を入力してください")
    end

    it 'first_name_kanaがカタカナ以外だと登録できないこと' do
      @user.first_name_kana = 'gん太'
      @user.valid?
      expect(@user.errors.full_messages).to include('フリガナ(名前)を全角で入力してください')
    end

    it 'birth_dateが必須であること' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end
end
