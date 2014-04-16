Learnenova::Application.routes.draw do
  root to: "home#index"

  get "home/index"
  devise_for :users, controllers: {:registrations => "registrations"}
  resources :users
  get "modules/:action", controller: "modules"
end
