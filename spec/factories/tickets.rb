FactoryGirl.define do
  factory :ticket do
    customer { Faker::Internet.email }
    title { Faker::Lorem.word }
    department
    status
  end
end
