FactoryGirl.define do

  factory :forum do
    name Faker::Lorem.words.join(" ").titleize
    description Faker::Lorem.sentence
  end

  factory :post do
    content Faker::Lorem.paragraphs.join("\n")

    topic
    user
  end

  factory :topic do
    title Faker::Lorem.words.join(" ").titleize
    views "rand((1..2000))".to_i

    forum
    user
  end

  factory :user do
    sequence(:username) { |n| "#{Faker::Internet.user_name}_#{n}"}
    sequence(:email) { |n| "#{Faker::Internet.email}_#{n}"}
    password "please"
  end

end
