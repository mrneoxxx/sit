FactoryGirl.define do
  factory :user do
    name { Faker::Lorem.word }
    email { Faker::Internet.email }
    password { Faker::Crypto.md5 }
    department
    tickets { build_list :ticket, 3 }
  end
end
