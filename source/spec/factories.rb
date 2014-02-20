FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.word }
    content { Faker::Lorem.sentence }
  end
end