FactoryBot.define do
  factory :comment do
    content 'This is a new comment'
    user_id 1
    post_id 1
  end

  factory :random_comment, class: Comment do
    content { Faker::Lorem.sentence(5) }
    user_id 1
    post_id 1
  end

end
