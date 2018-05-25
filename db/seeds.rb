# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
  {first_name: 'Kyle', last_name: 'Lemon', email:'Kyle@email.com', password: 'password'},
  {first_name: 'Paul', last_name: 'Rail', email:'Paul@email.com', password: 'password'},
  {first_name: 'Ariel', last_name: 'Camus', email:'Ariel@email.com', password: 'password'},
  {first_name: 'Kevin', last_name: 'Wahome', email:'Kevin@email.com', password: 'password'}])

# events = Event.create([{ title: "Something long enough", host_id: 1, description: "Text goes here, I hope.",              location: "Somewhere", date: "2018-08-01" },
#                      { title: "This is the 2nd event", host_id: 2, description: "2nd Text goes here, I hope.", location: "2nd location", date: "2018-09-01" },
#                      { title: "This is the 3rd event", host_id: 1, description: "3rd Text goes here, I hope.", location: "3rd location", date: "2018-10-31" }])
#
# # For invites, create 4 (2 events x 2 invites each):
# # Event 1: hosted by Person1, both accept.
# # Event 2: hosted by Person2, only host is confirmed.
# invites = Invite.create([{attended_event_id: 1, attendee_id: 2, accepted: true},{attended_event_id: 1, attendee_id: 1, accepted: true},{attended_event_id: 2, attendee_id: 2, accepted: true},{attended_event_id: 2, attendee_id: 1, accepted: false}])
