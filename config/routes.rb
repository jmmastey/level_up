Learnenova::Application.routes.draw do
  root to: "home#index"
  get "/:module.html", to: "home#show"

  devise_for :users, controllers: {:registrations => "registrations"}
  resources :users
  resources :courses, only: [:index, :show]
  resources :skills, only: [] do
    post "complete"
  end
end
