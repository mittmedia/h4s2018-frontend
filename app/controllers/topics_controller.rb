class TopicsController < ApplicationController
  def index
    @topics = JSON.parse(Api::Topic.all)["topics"].map do |topic|
      topic['type'] = 'card'
      topic['stage'] = 'Stage 6: voting'
      OpenStruct.new(topic)
    end
    # TODO: Do something with the trending topics design thing
    @user_topic_subscriptions = TopicSubscription.where(user_id: cookies[:user_id])
  end

  def show
    @documents = Api::Document.all
  end
end
