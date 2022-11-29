Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :products, only: %i[index show create] do
    resources :alerts, only: [:create]
  end

  resources :products, only: [:destroy]
  resources :alerts, only: %i[destroy update]

  resources :alerts do
    resources :matches, only: %i[create destroy index show]
  end



  get "/dashboard", to: "pages#dashboard", as: :dashboard
  get "/contact", to: "pages#contact", as: :contact
  get "/about", to: "pages#about", as: :about
  get "/team", to: "pages#team", as: :team
end
