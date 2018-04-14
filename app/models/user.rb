class User < ApplicationRecord
  has_many :region_subscriptions

  def subscribed_to
    regions = RegionSubscription.where(user: self).includes(:region).map(&:region)
    {
      regions: regions,
      tags: nil
    }
  end

  def subscribe_to(region)
    RegionSubscription.find_or_create_by!(user: self, region: region)
    true
  end

  def unsubscribe_from(region)
    RegionSubscription.find_by!(user: self, region: region).destroy
    true
  end
end
