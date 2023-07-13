Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registration: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    resources :services, only:[:index, :show, :create]
    resources :reservation, only:[:show, :create]
  end
end
