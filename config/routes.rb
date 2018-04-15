Rails.application.routes.draw do
  root 'topics#index'

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
