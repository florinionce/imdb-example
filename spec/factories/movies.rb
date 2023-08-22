FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    release_date { Faker::Date.between(from: '2000-01-01', to: '2021-12-31') }
    description { Faker::Lorem.paragraph }
    genre { Faker::Book.genre }
  end
end
