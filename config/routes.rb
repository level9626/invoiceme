Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  concern :email_templates do
    resources :invoice_email_templates do
      member do
        get :copy
      end
    end
  end

  devise_for :users

  resources :users, only: [], concerns: [:email_templates]

  resources :payments

  resources :clients, concerns: [:email_templates]

  resources :companies

  resources :invoices do
    resources :invoice_mails
    member do
      Invoice.state_machines[:state].events.map(&:name).each do |event|
        get event
      end
    end
    collection do
      get :statistics
    end
  end

  authenticated :user do
    devise_scope :user do
      root to: 'dashboard#show', as: 'dashboard'
    end
  end

  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new', as: 'unauthenticated'
    end
  end
end
