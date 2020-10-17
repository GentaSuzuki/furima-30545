FactoryBot.define do
  factory :order_address do
    token          { 'a' }
    post_code      { '421-0101' }
    prefecture_id  { 1 }
    city           { '福岡県' }
    house_number   { '福岡市東区箱崎' }
    phone_number   { '08011112222' }
  end
end
