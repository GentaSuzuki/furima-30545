FactoryBot.define do
  factory :user do
    nickname           { 'suzuki' }
    email              { 'suzuki@.gmail.com' }
    password           { 'test12345' }
    encrypted_password { 'test12345' }
    last_name          { '鈴木' }
    first_name         { '源太' }
    last_name_kana     { 'スズキ' }
    first_name_kana    { 'ゲンタ' }
    birth_date         { '1999-10-20' }
  end
end
