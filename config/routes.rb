Rails.application.routes.draw do
  namespace :admin do
    root "application#index"

    resources :projects, expect: [:index, :show]

    resources :users do
      member do
        patch :archive
      end
    end
    resources :states do
      member do
        patch :make_default
      end
    end
  end
  devise_for :users
  root "projects#index"

  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      collection do
        post :upload_file
      end
    end
  end

  scope path: "tickets/:ticket_id", as: :ticket do
    resources :comments, only: [:create]
  end

  mount ActiveStorage::Engine => "/rails/active_storage"

  # match '*path', to: 'application#redirect_to_root', via: :all
end
