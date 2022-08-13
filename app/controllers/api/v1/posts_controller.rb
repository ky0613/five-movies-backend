class Api::V1::PostsController < ApplicationController

  def create

    created_image_path = CreateImage.new(params[:image_paths], params[:uuid]).create_image

    post = Post.new(post_params)
    post.image = File.open(created_image_path)

    if post.save

      params[:movie_ids].each do |id|
        post.movies.create(movie_id: id)
      end

      # 一時ファイルを削除
      File.delete(created_image_path)

      render json: post.uuid, status: :ok
    else
      render json: { error: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    post = Post.where(uuid: params[:uuid])
    movies = post.movies.all
    render json: movies
  end

  private

  def post_params
    params.require(:post).permit(:uuid, :name)
  end
end
