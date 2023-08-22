# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

10.times do
  Actor.create(
    name: Faker::Name.first_name,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
    bio: Faker::Lorem.paragraph
  )
end

10.times do
  Movie.create(
    title: Faker::Movie.title,
    release_date: Faker::Date.between(from: '2000-01-01', to: '2021-12-31'),
    description: Faker::Lorem.paragraph,
    genre: Faker::Book.genre
  )
end

Actor.all.each do |actor|
  rand(2..5).times do
    movie = Movie.all.sample

    Role.create(
      actor_id: actor.id,
      movie_id: movie.id,
      character_name: Faker::Superhero.name
    )
  end
end
