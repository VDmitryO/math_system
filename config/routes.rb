Rails.application.routes.draw do
  resources :tasks, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tasks#index'
  get 'result', to: 'tasks#result'
  get 'authorization', to: 'authorization#index'
  post 'authorization', to: 'authorization#authorization'
  post 'exit', to: 'authorization#exit'
end
