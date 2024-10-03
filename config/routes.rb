Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/signup', to: 'auth#signup'
  post '/login', to: 'auth#login'

  resources :users, only: [:index, :create]
  resources :items, only: [:index, :create, :update, :show]
end
