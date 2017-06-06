FactoryGirl.define do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  factory :user do
    email { Faker::Internet.email}
    password  "password"

    trait :first_name_last_name do
      first_name first_name
      last_name last_name
    end

  end
end

