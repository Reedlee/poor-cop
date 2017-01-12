Rails.application.routes.draw do

  resources :points, :only => [:index, :create, :new]
  root 'points#index'

  # get '/points', to: 'points#index', as: 'points'
  # post '/point/new', to: 'points#create', as: 'new_point'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
