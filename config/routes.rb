ChaiIo::Application.routes.draw do

  root :to => 'home#index'
  get '/' => 'home#index'


  namespace :admin do
    get '/' => 'admin#index'
    resources :users do
      put 'lock'
      put 'unlock'
    end
  end


  get '/logout' => 'sessions#destroy'
  get '/r/:id/:hash' => 'reports#public'
  resources :sessions

  get '/console' => 'console#index'
  post '/console/run' => 'console#run'

  get '/reports/search' => 'reports#search'
  get '/reports/starred' => 'reports#starred'
  get '/reports/shared' => 'reports#shared'
  get '/reports/tags/:tag' => 'reports#tagged_with'
  resources :reports do
    get 'share'
    get 'unshare'
    get 'star'
  end

  match '/datasources/test' => 'datasources#test', :via => :post
  resources :datasources

  resources :users
  resources :projects

  resources :projects do
    resources :reports do
      get 'share'
      get 'unshare'
    end
    resources :dashboards
  end


end
