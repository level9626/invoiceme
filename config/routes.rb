Rails.application.routes.draw do
  resources :payments

  mount Upmin::Engine => '/admin'

  resources :clients

  resources :companies

  resources :invoices

  devise_for :users

  authenticated :user do
    devise_scope :user do
      root to: "profiles#profile", :as => "profile"
    end
  end

  root to: 'visitors#index'
end
