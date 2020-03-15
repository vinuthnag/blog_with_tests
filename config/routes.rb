Rails.application.routes.draw do
  resources :posts do
  	resources :comments
  end
  match 'welcome', to: 'users#index', via: [:get]
  resources :users 
  root 'users#index'
  match 'login', to: 'users#login', via: [:post]
  match 'logout', to: 'users#logout', via: [:get]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 