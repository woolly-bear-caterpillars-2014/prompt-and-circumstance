# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Alexei Pesic"
    email "test@test.com"
    password "apeapeape"
  end
end

FactoryGirl.define do
  factory :teste_user do
    name "Teste"
    email "teste@teste.teste"
    password "testeteste"
  end
end
