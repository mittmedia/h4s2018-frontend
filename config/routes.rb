Rails.application.routes.draw do
  resources 'topics', only: [:index, :show]
  resources :users, only: [:create, :destroy]
  root 'intro#show'
end
