Learnenova::Application.routes.draw do
  root to: "home#index"
  get "/:module.html", to: "home#show"

  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:update, :show]
  resources :courses, only: [:index, :show] do
    post "enroll"
  end

  resources :skills, only: [] do
    post "completion", to: "skills#complete", as: :complete
    delete "completion", to: "skills#uncomplete", as: :uncomplete
  end
end
