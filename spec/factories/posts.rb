# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    topic_id 1
    user_id 1
    content "MyText"
  end
end
