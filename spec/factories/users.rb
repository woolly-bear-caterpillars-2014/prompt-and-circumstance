# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }

  factory :user do
    name Faker::Internet.user_name
    email
    password "apeapeape"
  end
end


