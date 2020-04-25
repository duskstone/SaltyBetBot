# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Bet.destroy_all
BetPool.destroy_all

u1 = User.create!(username: "jgyaniv", salt: 5000)
u2 = User.create!(username: "duskstone", salt: 5000)
u3 = User.create!(username: "Aydreeyun", salt: 5000)

p1 = BetPool.create!(title: "We live in the matrix.", user_id: u1.id)
p2 = BetPool.create!(title: "Patrick will never lecture.", user_id: u2.id)

b1 = Bet.create!(user_id: u1.id, bet_pool_id: p1.id, wager: 1000, action:true)
b2 = Bet.create!(user_id: u2.id, bet_pool_id: p1.id, wager: 1000, action:false)
b3 = Bet.create!(user_id: u3.id, bet_pool_id: p1.id, wager: 1000, action:true)
b4 = Bet.create!(user_id: u1.id, bet_pool_id: p2.id, wager: 1000, action:false)
b5 = Bet.create!(user_id: u2.id, bet_pool_id: p2.id, wager: 1000, action:true)