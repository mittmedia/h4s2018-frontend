class TopicSubscription < ApplicationRecord
  belongs_to :user

  def self.trending
    trending = TopicSubscription.group(:topic_id)
                                .order('count_topic_id desc')
                                .count('topic_id')
    keys = trending.delete_if { |key, value| value < 2 }.keys
    keys.map(&:upcase)
  end
end
