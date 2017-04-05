Rails.application.routes.draw do

  root 'points#index'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :points, :only => [:index, :new, :create]
      get 'points/:id/confirm', to: 'points#confirm', as: 'point_confirm'

      post 'users/start_registration', to: 'users#start_registration', as: 'start_registration_user'
      post 'users/confirm', to: 'users#confirm', as: 'phone_confirm'
    end
  end

  namespace :admin do
    resources :points, :only => [:index, :new, :create, :destroy]
    get 'points/:id/confirm', to: 'points#confirm', as: 'point_confirm'

    get 'users', to: 'users#index', as: 'users'
    post 'users/activate', to: 'users#activate', as: 'activate'
  end
end
