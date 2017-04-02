Rails.application.routes.draw do

  root 'points#index'

  namespace :api do
    namespace :v1 do
      resources :points, :only => [ :index, :new, :create]
      get 'points/:id/confirm', to: 'points#confirm', as: 'confirm'
    end
  end

  namespace :admin do
    resources :points, :only => [ :new, :create, :destroy]
    get 'points/:id/confirm', to: 'points#confirm', as: 'confirm'
  end
end
