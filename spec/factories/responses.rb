# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :response do
     body 'My name is yeff'
     user_id 1
     prompt_id 1
  end
end
