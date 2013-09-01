Attestation::Application.routes.draw do
  devise_scope :user do
	  root to: "tasks#index"
	end

  devise_for :admins

  devise_for :users

  namespace :admin do
    root to: 'tasks#index'
    resources :tasks
    resources :results
  end

  resources :tasks

  root to: "tasks#index"
end
