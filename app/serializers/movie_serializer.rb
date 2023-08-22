class MovieSerializer < ApplicationSerializer
  def initialize(movie, includes_actors: false)
    super(movie)

    @includes_actors = includes_actors
  end

  root_key :movie, :movies

  attributes :id, :title, :description, :genre

  attribute :year do |movie|
    movie.release_date.year
  end

  attribute :actors, if: proc { @includes_actors } do |movie|
    ActorSerializer.new(movie.actors).serializable_hash
  end

  meta do
    if object.is_a?(Enumerable)
      { size: object.size }
    else
      { foo: :bar }
    end
  end
end
