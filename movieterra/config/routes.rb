Rails.application.routes.draw do
  constraints subdomain: 'api' do
    get '/recommendations', to: 'welcome#recommendations'
    post '/tickets', to: 'welcome#tickets'
  end

  root to: 'welcome#index'

  resources :movies do
    get :search, on: :collection
  end

  resources :users
  resources :tickets
  resource :session

end
