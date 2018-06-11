# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  { first_name: 'Kyle',  last_name: 'Lemon',  email: 'Kyle@email.com',  password: 'password' },
  { first_name: 'Paul',  last_name: 'Rail',   email: 'Paul@email.com',  password: 'password' },
  { first_name: 'Ariel', last_name: 'Camus',  email: 'Ariel@email.com', password: 'password' },
  { first_name: 'Kevin', last_name: 'Wahome', email: 'Kevin@email.com', password: 'password' },
  { first_name: 'Sava', last_name: 'Vuckovic', email: 'Sava@email.com', password: 'password' },
  { first_name: 'Michael', last_name: 'LongName', email: 'Mike@email.com', password: 'password' },
  { first_name: 'Emily', last_name: 'LongName', email: 'Emily@email.com', password: 'password' },
  { first_name: 'Alvaro', last_name: 'Diaz', email: 'Alvaro@email.com', password: 'password' }])

users = User.all


# 5 posts for each user:
3.times do
  users.each { |user| user.posts.create(content: Faker::Lorem.sentence(5)) }
end

# each post have random number of comments (0 - 4)
posts = Post.all
posts.each do |post|
  rand(0..4).times do
    # assign random user id from 1-5 (there is no 0)
    post.comments.create(user_id: rand(1..5), content: Faker::Lorem.sentence)
  end
end

# each post have random number of likes (0 - 4)
posts = Post.all
posts.each do |post|
  rand(0..4).times do
    post.likes.create(user_id: rand(1..5))
  end
end


# 2 friends for each user:
users = User.all
2.times do
  users.each do |user|

    # requestee can't be the same as current user
    requestee_id_num = rand(1..8)
    while requestee_id_num == user.id || user.requestees.include?(User.find(requestee_id_num)) do
      requestee_id_num = rand(1..8)
    end

    user.sent_requests.create(requestee_id: requestee_id_num, accepted: 1)
    User.find(requestee_id_num).sent_requests.create(requestee_id: user.id, accepted: 1)
  end
end
