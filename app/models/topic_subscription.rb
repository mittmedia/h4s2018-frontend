class TopicSubscription < ApplicationRecord
  belongs_to :user

  # def trending
  #   TopicSubscription.group(:story).order(count_subscribers asc).count('subscribers')
  # end
end
