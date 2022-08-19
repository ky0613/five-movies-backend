Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[index create show],param: :uuid do
        collection do
          get 'search'
        end
      end

      get 'movies/search'
      get 'movies/ranking'
      get 'movies/search_list'
    end
  end
end
