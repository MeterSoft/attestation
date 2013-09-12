Attestation::Application.routes.draw do
  
  devise_scope :user do
    root to: "tasks#index"
    resources :results, only: [:index, :search] do
      collection do
        get :search
      end
    end
  end
  devise_for :admins
  devise_for :users

  namespace :admin do
    root to: 'tasks#index'
    resources :tasks do
      collection do
        get :search
        post :import
      end
    end
    resources :results do
      collection do
        get :search
      end
    end
  end

  resources :tasks do
    collection do
      get :search
    end
  end
  resources :languages
end