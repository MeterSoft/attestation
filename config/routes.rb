Attestation::Application.routes.draw do
  
  devise_scope :user do
    root to: "tasks#index"
  end
  devise_for :admins
  devise_for :users

  namespace :admin do
    root to: 'admins#index'
    resources :tasks do
      collection do
        get :search
        post :import
      end
    end
    resources :results
    resources :admins
  end

  resources :tasks do
    collection do
      get :search
    end
  end
  resources :languages

end