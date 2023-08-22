class Movie < ApplicationRecord
  has_many :roles
  has_many :actors, through: :roles

  validates :title, presence: true
end
