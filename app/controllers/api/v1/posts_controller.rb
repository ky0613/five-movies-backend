class Api::V1::PostsController < ApplicationController

  def index
    posts = Post.order(created_at: :desc).page(params[:page]).per(10)

    render json: posts, status: :ok
  end

  def create
    post = Post.new(post_params)

    # 画像作成前にバリデーションを適用させる
    return render json: { error: post.errors.full_messages }, status: :unprocessable_entity if post.invalid?

    created_image_path = CreateImage.new(params[:image_paths], params[:uuid]).create_image
    post.image = File.open(created_image_path)

    if post.save(context: :post_image_setup)
      params[:movies].each do |movie|
        movie_instance = post.movies.new(movie_id: movie[:id], title: movie[:title])
        movie_instance.save!
      end

      # 一時画像ファイルを削除
      File.delete(created_image_path)

      render json: post.uuid, status: :ok
    else
      render json: { error: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    post = Post.find_by(uuid: params[:uuid])
    movies = post.movies.all
    get_movies = GetMovieData.get_movies_data_from_tmdb(movies)
    render json: { movies: get_movies, post: post }, status: :ok
  end

  def search
    posts = Movie.where(title: params[:search_title]).map(&:post)
    render json: posts, status: :ok
  end

  private

  def post_params
    params.require(:post).permit(:uuid, :name)
  end

end
