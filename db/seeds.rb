require 'faker'

20.times do
  prompt = Prompt.create(
    :title => Faker::Company.catch_phrase,
    :description => Faker::Lorem.paragraph
  )
  rand(4..10).times do
    prompt.responses.create(body: Faker::Hacker.say_something_smart)
  end
end