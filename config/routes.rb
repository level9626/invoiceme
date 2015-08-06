Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  concern :attachable do
    resources :attachments
  end

  concern :commentable do
    resources :comments, concerns: :attachable
  end

  concern :email_templates do
    resources :invoice_email_templates, concerns: :attachable do
      member do
        get :copy
      end
    end
  end

  devise_for :users

  resources :users, only: [], concerns: [:email_templates]

  namespace :api do
    resources :payments, concerns: [:commentable, :attachable]
    resources :payments
    resources :clients, concerns: [:email_templates]
    resources :companies do
      collection do
        get 'default'
      end
    end

    resources :invoices, concerns: [:commentable, :attachable], \
                         except: [:edit] do
      resources :invoice_mails
      member do
        Invoice.state_machines[:state].events.map(&:name).each do |event|
          get event
        end
      end
      collection do
        get :statistics
        get :invoice_number
        get :states
      end
    end

    get 'profiles/percent_payed' => 'profiles#percent_payed'
  end

  authenticated :user do
    devise_scope :user do
      root to: 'application#index', as: 'dashboard'
    end
  end

  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new', as: 'unauthenticated'
    end
  end

  get '*path' => 'application#index'
end
