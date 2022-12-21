Rails.application.routes.draw do
  
  root 'pages#home'
  
  devise_for :users
  get 'pages/home'
  get 'dashboard', to: 'users#dashboard'
  get 'users/:id', to: 'users#show', as: 'user'

  post '/users/edit', to: 'users#update'

  resources :rooms, except: [:edit] do
    member do
      get 'listing'
      get 'pricing'
      get 'description'
      get 'photo_upload'
      get 'amenities'
      get 'location'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
