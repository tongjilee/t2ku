T2ku::Application.routes.draw do
  constraints(Subdomain){match '/'=>'tasks#new'}
  devise_for :users,:path => 'd' do
    get "/register", :to => "registrations#new"
    get "/login", :to => "devise/sessions#new"
    get "/logout", :to => "devise/sessions#destroy"
  end
  
  resources :users
  resources :tasks
  resources :books
  resources :compilations
  resources :definitions
  resources :theorems
  resources :problems
  resources :references
  resources :helps
  get 'account' => 'account#index',:as=>'account'
  get 'downloads' => 'home#downloads',:as=>'downloads'
  get 'about' => 'home#about',:as=>'about'

  root :to => 'home#index'  
  post '/ajax/create_user' => 'ajax#create_user'
end
