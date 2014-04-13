Learnenova::Application.routes.draw do
  get "home/index"
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end