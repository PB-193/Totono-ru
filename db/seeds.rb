# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "-------------create start------------"

#     3.times do |n|
#       User.create!(
#         email: "test#{n + 1}@gmail.com",
#         name: "テスト#{n + 1}さん",
#         password: "ikmikm",
#         password_confirmation: "ikmikm"
#       )
#     end

# puts "-------------user create------------"

#     User.all.each do |user|
#       user.contents.create!(
#         visit_day: Date.new(2023, 6, 10),
#         spot: "レインボー",
#         title: "タイトル",
#         text: "ととのいました",
#       )
#     end

# puts "------------content create------------"

#     Tag.create!(name: "サ活")
#     Tag.create!(name: "水風呂")
#     Tag.create!(name: "サウナ飯")
#     Tag.create!(name: "グッズ")
#     Tag.create!(name: "聖地巡礼")

# puts "------------tag create------------"

    Admin.create!(
      email: "admin@com",
      password: "ikmikm"
    )

puts "------------admin create------------"

