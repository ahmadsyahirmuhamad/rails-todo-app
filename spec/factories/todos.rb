FactoryGirl.define do

  factory :todo do
    association :user
    title { Faker::Lorem.word }
    description  { Faker::Lorem.word }

    trait :completed do
      complete true
    end

  end
end


