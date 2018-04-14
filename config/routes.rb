Rails.application.routes.draw do
  root 'topics#index'

  get '/regions/county', to: 'regions#county'
  get '/regions/county/:county_id', to: 'regions#municipalities_for_county'
  get '/regions/municipalities/', to: 'regions#municipalities'
  get '/regions/municipalities/:municipality_id', to: 'regions#cities_for_municipalities'
  get '/regions/cities', to: 'regions#cities'

  resources :topics, only: [:index, :show]
  resources :users, only: [:create, :destroy] do
    get 'regions_subscribed_to'
    put 'subscribe_to_region'
    put 'unsubscribe_from_region'

    get 'topics_subscribed_to'
    put 'subscribe_to_topic'
    put 'unsubscribe_from_topic'

    put 'register_notifications'
  end
end
