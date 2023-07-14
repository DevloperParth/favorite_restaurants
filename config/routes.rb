Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  namespace :api do
    namespace :v1 do
      resources :restaurants do
        member do
          post 'favorite'
        end
      end
      post '/search', to: 'restaurants#search'
    end
  end
end
