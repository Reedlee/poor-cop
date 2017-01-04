Rails.application.routes.draw do
  get '/points', to: 'points#index', as: 'points'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
