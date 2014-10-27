Levelup::Application.routes.draw do
  root to: "home#index"
  get "/thedeal.html", to: "home#thedeal"
  get "/:module.html", to: "home#show", as: :module

  devise_for :users, controllers: { registrations: "registrations",
                                    omniauth_callbacks: "omniauth_callbacks" }

  resources :users, only: [:index, :update, :show]
  resources :courses, only: [:index, :show]

  post "courses/:id/enroll", to: "courses#enroll", as: "enroll"
  post "send_feedback", to: "home#send_feedback", as: "feedback"

  resources :skills, only: [] do
    post "completion", to: "skills#complete", as: :complete
    delete "completion", to: "skills#uncomplete", as: :uncomplete
  end
end
