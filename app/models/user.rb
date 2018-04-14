class User < ApplicationRecord
  has_many :region_subscriptions

  # REGIONS

  def regions_subscribed_to
    regions = RegionSubscription.where(user: self).includes(:region).map(&:region)
    {
      regions: regions,
    }
  end

  def subscribe_to_region(region)
    RegionSubscription.find_or_create_by!(user: self, region: region)
    true
  end

  def unsubscribe_from_region(region)
    RegionSubscription.find_by!(user: self, region: region).destroy
    true
  end

  # TOPICS

  def topics_subscribed_to
    topics = TopicSubscription.where(user: self).pluck(&:topic_id)
    {
      topics: topics,
    }
  end

  def subscribe_to_topic(topic_id)
    TopicSubscription.find_or_create_by!(user: self, topic_id: topic_id)
    true
  end

  def unsubscribe_from_topic(topic_id)
    TopicSubscription.find_by!(user: self, topic_id: topic_id).destroy
    true
  end
end
