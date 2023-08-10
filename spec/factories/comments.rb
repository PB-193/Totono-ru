FactoryBot.define do
  factory :comment do
    association :user
    association :content
    comment { Faker::Lorem.sentence } 
  end
end
