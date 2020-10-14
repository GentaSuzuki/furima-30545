FactoryBot.define do
  factory :item do
    name          { 'name' }
    description   { 'description' }
    category_id   { 1 }
    condition_id  { 1 }
    postage_id    { 1 }
    prefecture_id { 1 }
    day_ship_id   { 1 }
    price         { 5000 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    association :user
  end
end
