NetspireAdmin::Application.routes.draw do
  devise_for :admin

  root :to => 'admin/dashboard#index'

  devise_scope :admin do
    get "/logout" => "devise/sessions#destroy", :as => :destroy_admin_session
  end

  namespace :admin do
    match '/dashboard', :to => 'dashboard#index', :as => :dashboard

    match '/profile', :to => 'admins#edit', :as => :profile

    resources :admins do
      member do
        get :reset_auth_token
      end
    end

    resources :accounts do
      member do
        put :deposit
        put :withdraw
        get :lock
        get :unlock
      end
    end

    scope("/billing") do
      resources :plans
      resources :billing_cycles, :path => "cycles"
      resources :billing_periods, :path => "periods"
    end

    resources :transactions
    resources :assigned_services
  end
end
