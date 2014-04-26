Learnenova::Application.routes.draw do
  root to: "home#index"

  devise_for :users, controllers: {:registrations => "registrations"}
  resources :users
  resources :modules

  resources :skills, only: [] do
    post "complete"
  end
end
