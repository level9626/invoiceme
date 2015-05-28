Rails.application.routes.draw do
  devise_for :users

  ActiveAdmin.routes(self)

  resources :payments

  resources :invoice_email_templates do
    member do
      get :copy
    end
  end

  resources :clients do
    resources :invoice_email_templates
  end

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

  mount Commontator::Engine => '/commontator'
end
