Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index create show],param: :uuid
      get 'movies/search'
      get 'movies/ranking'
    end
  end
end
