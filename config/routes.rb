Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do

      resources :contents, only: %i[index create update destroy]

    # login
      post 'login', to: 'sessions#create'
    # signup
      post 'signup', to: 'users#create'
    end
  end
end
