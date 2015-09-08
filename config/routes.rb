Levelup::Application.routes.draw do
  root to: "home#index"
  get "/thedeal.html", to: "home#thedeal"
  get "(/:organization)/:category.html", to: "home#show", as: :category

  devise_for :users, controllers: { registrations: "registrations",
                                    omniauth_callbacks: "omniauth_callbacks" }

  resources :users, only: [:index, :update, :show]
  resources :courses, only: [:index, :show]
  resources :deadlines, only: [:create, :destroy] do
    collection do
      post "toggle"
    end
  end

  post "courses/:id/enroll", to: "courses#enroll", as: "enroll"
  post "send_feedback", to: "home#send_feedback", as: "feedback"

  resources :skills, only: [] do
    post "completion", to: "skills#complete", as: :complete
    delete "completion", to: "skills#uncomplete", as: :uncomplete
  end

  get "/unsubscribe", to: "unsubscribe#index", as: :unsubscribe
  get "/unsubscribe/:token", to: "unsubscribe#confirm"
end
