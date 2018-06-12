FactoryBot.define do
  factory :user do
    first_name 'New'
    last_name 'Student'
    email 'new@email.com'
    password 'password'
  end

  # factory :random_post, class: Post do
  #   content { Faker: :Post.content }
  #   user_id { Faker: :Post.user_id }
  # end

end
