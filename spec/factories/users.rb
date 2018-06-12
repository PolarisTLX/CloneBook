FactoryBot.define do
  factory :user do
    first_name 'New'
    last_name 'Student'
    email 'new@email.com'
    password 'password'
  end

  factory :random_user, class: User do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.first_name }
    email      { Faker::Internet.safe_email }
    password   'password'
  end

end
