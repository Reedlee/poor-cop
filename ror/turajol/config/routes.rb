Rails.application.routes.draw do

  root 'points#index'
  resources :points, :only => [:create, :new, :destroy]
end
