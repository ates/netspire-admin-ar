NetspireAdmin::Application.routes.draw do
  devise_for :admin

  root :to => 'admin/dashboard#index'

  devise_scope :admin do
    get "/logout" => "devise/sessions#destroy", :as => :destroy_admin_session
  end

  namespace :admin do
    match '/dashboard', :to => 'dashboard#index', :as => :dashboard

    match '/profile', :to => 'admins#edit', :as => :profile

    resources :admins

    resources :accounts do
      member do
        put :deposit
        put :withdraw
      end
    end

    resources :transactions
  end
end
