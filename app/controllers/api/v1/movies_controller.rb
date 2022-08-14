class Api::V1::MoviesController < ApplicationController

  def search

    movies = GetMovieData.search_movies(params[:search_word])

    render json: movies, status: :ok
  end
end
