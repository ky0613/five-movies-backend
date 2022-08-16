class Api::V1::MoviesController < ApplicationController

  def search
    movies = GetMovieData.search_movies(params[:search_word], params[:page])

    render json: movies, status: :ok
  end
end
