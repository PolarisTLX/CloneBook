FactoryBot.define do
  factory :post do
    content 'This is a new post'
    user_id 1
  end

  factory :random_post, class: Post do
    content { Faker::Lorem.sentence(5) }
    user_id  1
  end

end
