Rails.application.routes.draw do

  root 'points#index'
  resources :points, :only => [ :new, :create, :destroy]
  get 'points/:id/confirm', to: 'points#confirm', as: 'confirm'
end
