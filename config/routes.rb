Rails.application.routes.draw do
  get '/municipalities.json', to: 'regions#municipalities'
  get '/cities.json', to: 'regions#cities'
  resources :topics, only: [:index, :show]
  resources :users, only: [:create, :destroy] do
    get 'subscribed_to'
    put 'subscribe_to'
    put 'unsubscribe_from'
    put 'subscribe'
  end
  root 'intro#show'
end
