require 'faker'


Prompt.create(title: 'Hacker Joke!', description: 'How many hackers does it take to screw in a lightbulb?')


Prompt.first.responses.create(body: "12factor")
Prompt.first.responses.create(body: "2 to pair, one to merge the lightbulb into the socket")
Prompt.first.responses.create(body: "One... but he'll just make a new socket instead")

Prompt.create(title: 'Hacker Joke 2!', description: 'What do Hackers eat for Breakfast?')

Prompt.last.responses.create(body: "Windows")
Prompt.last.responses.create(body: "Soylent")
Prompt.last.responses.create(body: "Diet Coke")
Prompt.last.responses.create(body: "Crackers")

Prompt.create(title: 'Hacker Joke 3!', description: 'Hacker Pickup Lines?')

Prompt.last.responses.create(body: "Oauth, I wanna log into your database.")
Prompt.last.responses.create(body: "Maybe later we could checkout and rebase?")
Prompt.last.responses.create(body: "Git commit -m 'anything for you baby'")
Prompt.last.responses.create(body: "Checkout my hardrive")
Prompt.last.responses.create(body: "Is your repo private, or can I contribute?")



20.times do
  prompt = Prompt.create(
    :title => Faker::Company.catch_phrase,
    :description => Faker::Lorem.paragraph
  )
  rand(4..10).times do
    prompt.responses.create(body: Faker::Hacker.say_something_smart)
  end
end
