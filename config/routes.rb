Rails.application.routes.draw do
  resources 'topics', only: [:index, :show]
  resources :users, only: [:create, :destroy] do
    put 'subscribe'
  end
  root 'intro#show'
end
