require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http


class SaveMovieTitle

  BASE_URL = "https://api.themoviedb.org/3"

  def initialize
    @api_key = Rails.application.credentials.tmdb[:api_key]
    @connection = Faraday.new(ssl: { ca_path: "/opt/homebrew/etc/openssl@3" }, params: { api_key: @api_key, language: "ja" })
  end

  def save_movie_title
    movies = Movie.all
    newMovies = movies.map do |movie|
      response = @connection.get("#{BASE_URL}/movie/#{movie.movie_id}")
      movie.update(title: JSON.parse(response.body)["title"])
    end
  end
end
