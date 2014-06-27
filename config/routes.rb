Levelup::Application.routes.draw do
  root to: "home#index"
  get "/thedeal.html", to: "home#thedeal"
  get "/:module.html", to: "home#show"

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:update, :show]
  resources :courses, only: [:index, :show]
  post "courses/:id/enroll", to: "courses#enroll", as: "enroll"

  resources :skills, only: [] do
    post "completion", to: "skills#complete", as: :complete
    delete "completion", to: "skills#uncomplete", as: :uncomplete
  end
end
