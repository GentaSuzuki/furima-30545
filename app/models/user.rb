class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  with_options presence: true do
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'を全角で入力してください' }
    validates :last_name_kana,  format: { with: /\A[ァ-ヶー－]+\z/, message: 'を全角で入力してださい' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'を全角で入力してください' }
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'は半角英数字混合で入力してください' }
    validates :password_confirmation, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: '確認用パスワードを入力してください' }
  end
  validates :birth_date, presence: true

  has_many :orders
  has_many :items
end
