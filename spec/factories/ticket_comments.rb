FactoryGirl.define do
  factory :ticket_comment do
    ticket
    body { Faker::Lorem.paragraph }
  end
end
