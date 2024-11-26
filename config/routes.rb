Rails.application.routes.draw do
  namespace :admin do
    root "application#index"

    resources :projects, expect: [:index, :show]
  end
  devise_for :users
  root "projects#index"

  resources :projects, only: [:index, :show] do
    resources :tickets
  end
end
