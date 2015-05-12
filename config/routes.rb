Rails.application.routes.draw do
  resources :invoice_mails

  resources :invoice_email_templates

  resources :payments

  resources :clients

  resources :companies

  resources :invoices do
    member do
      Invoice.state_machines[:state].events.map(&:name).each do |event|
        get event
      end
    end
    collection do
      get :statistics
    end
  end

  devise_for :users

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

  mount Upmin::Engine => '/admin'

  mount Commontator::Engine => '/commontator'
end
