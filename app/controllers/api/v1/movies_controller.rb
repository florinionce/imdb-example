class Api::V1::MoviesController < ApplicationController
  def index
    movies = Movie.all

    # render json: {
    #   movies: MovieSerializer.new(movies).serializable_hash,
    #   meta: { total: movies.count }
    # }

    render json: MovieSerializer.new(movies).serialize
  end

  def show
    movie = Movie.find(params[:id])

    render json: MovieSerializer.new(movie, includes_actors: true).serialize
  end

  def create
    movie = Movie.create!(movie_params)

    render json: MovieSerializer.new(movie).serialize, status: :created
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :genre, :release_date)
  end
end
