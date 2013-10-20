ChaiIo::Application.routes.draw do
  
  root :to => 'home#index'
  get '/' => 'home#index'
  
  get '/logout' => 'sessions#destroy'
  get '/r/:id/:hash' => 'reports#public'


  resources :sessions

  get '/reports/search' => 'reports#search'
  resources :reports do
    get 'share'
    get 'unshare'
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
  end


end
