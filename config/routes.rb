Rails.application.routes.draw do
  resources :payments

  mount Upmin::Engine => '/admin'

  mount Commontator::Engine => '/commontator'

  resources :clients

  resources :companies

  resources :invoices do
    member do
      Invoice.state_machines[:state].events.map(&:name).each do |event|
        get event
      end
    end
  end

  devise_for :users

  authenticated :user do
    devise_scope :user do
      root to: 'profiles#profile', as: 'profile'
    end
  end

  root to: 'visitors#index'
end
