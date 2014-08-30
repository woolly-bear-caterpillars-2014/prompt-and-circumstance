require 'faker'

10.times do
  User.create(
    name: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end

User.all.sample.prompts.create(title: 'Hacker Joke!', description: 'How many hackers does it take to screw in a lightbulb?')


Prompt.first.responses.create(body: "12factor", user_id: rand(1..10))
Prompt.first.responses.create(body: "2 to pair, one to merge the lightbulb into the socket", user_id: rand(1..10))
Prompt.first.responses.create(body: "One... but he'll just make a new socket instead", user_id: rand(1..10))

User.all.sample.prompts.create(title: 'Hacker Joke 2!', description: 'What do Hackers eat for Breakfast?')

Prompt.last.responses.create(body: "Windows", user_id: rand(1..10))
Prompt.last.responses.create(body: "Soylent", user_id: rand(1..10))
Prompt.last.responses.create(body: "Diet Coke", user_id: rand(1..10))
Prompt.last.responses.create(body: "Crackers", user_id: rand(1..10))

User.all.sample.prompts.create(title: 'Hacker Joke 3!', description: 'Hacker Pickup Lines?')

Prompt.last.responses.create(body: "Oauth, I wanna log into your database.", user_id: rand(1..10))
Prompt.last.responses.create(body: "Maybe later we could checkout and rebase?", user_id: rand(1..10))
Prompt.last.responses.create(body: "Git commit -m 'anything for you baby'", user_id: rand(1..10))
Prompt.last.responses.create(body: "Checkout my hardrive", user_id: rand(1..10))
Prompt.last.responses.create(body: "Is your repo private, or can I contribute?", user_id: rand(1..10))



20.times do
  prompt = Prompt.create(
    :title => Faker::Company.catch_phrase,
    :description => Faker::Lorem.paragraph,
    :user_id => rand(1..10)
  )
  rand(4..10).times do
    prompt.responses.create(body: Faker::Hacker.say_something_smart, user_id: rand(1..10))
  end
end
