# -*- encoding : utf-8 -*-
T2ku::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  constraints(Subdomain){match '/'=>'tasks#new'}
  devise_for :users,:path => 'd' do
    get "/register", :to => "registrations#new"
    get "/login", :to => "devise/sessions#new"
    get "/logout", :to => "devise/sessions#destroy"
  end
  
  resources :users
  resources :tasks
  resources :books do
    resources :pages
  end
  resources :definitions
  resources :theorems
  resources :problems
  resources :references
  resources :authors
  resources :helps
  get 'account' => 'account#index',:as=>'account'
  get 'downloads' => 'home#downloads',:as=>'downloads'
  get 'about' => 'home#about',:as=>'about'

  root :to => 'home#index'  
  post '/ajax/create_user' => 'ajax#create_user'
end
