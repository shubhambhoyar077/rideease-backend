Rails.application.routes.draw do
  resources :services
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    resources :services, only:[:index, :show, :create]
    resources :reservation, only:[:show, :create]
  end
end
