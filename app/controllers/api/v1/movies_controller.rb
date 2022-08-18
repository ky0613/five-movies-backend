class Api::V1::MoviesController < ApplicationController

  def search
    movies = GetMovieData.search_movies(params[:search_word], params[:page])

    render json: movies, status: :ok
  end

  def ranking
    movies = Movie.group(:movie_id).order("count_all DESC").limit(10).count
    get_movies = GetMovieData.get_movies_data_from_tmdb_for_ranking(movies.keys)
    ranking_movies = get_movies.map.with_index do |movie, index|
      movie["movie_count"] = movies.values[index]
      movie
    end
    render json: ranking_movies, status: :ok
  end
end
