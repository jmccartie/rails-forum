# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    forum_id 1
    title "MyString"
    user_id 1
    views 1
  end
end
