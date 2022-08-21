require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http

class GetMovieData

  BASE_URL = "https://api.themoviedb.org/3"

  def initialize
    @api_key = Rails.application.credentials.tmdb[:api_key]
    @connection = Faraday.new(ssl: { ca_path: "/opt/homebrew/etc/openssl@3" }, params: { api_key: @api_key, language: "ja" })
  end

  def search_movies(search_word, page)
    @connection.params[:query] = search_word
    @connection.params[:page] = page
    response = @connection.get("#{BASE_URL}/search/movie")
    response.body
  end

  def get_movies_data_from_tmdb(movies)
    get_movies = movies.map do |movie|
                  response = @connection.get("#{BASE_URL}/movie/#{movie.movie_id}")
                  JSON.parse(response.body)
                end
  end

  def get_movies_data_from_tmdb_for_ranking(movie_ids)
    get_movies = movie_ids.map do |id|
                  response = @connection.get("#{BASE_URL}/movie/#{id}")
                  JSON.parse(response.body)
                end
  end

  class << self
    def client
      GetMovieData.new
    end

    def search_movies(search_word, page)
      client.search_movies(search_word, page)
    end

    def get_movies_data_from_tmdb(movies)
      client.get_movies_data_from_tmdb(movies)
    end

    def get_movies_data_from_tmdb_for_ranking(movie_ids)
      client.get_movies_data_from_tmdb_for_ranking(movie_ids)
    end
  end
end
