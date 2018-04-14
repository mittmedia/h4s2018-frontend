class TopicsController < ApplicationController
  before_action :verify_topic, only: :show

  def index
    @topics = get_all_topics
    # TODO: Do something with the trending topics design thing
    @user_topic_subscriptions = TopicSubscription.where(user_id: cookies[:user_id])
  end

  def show
    topics = get_all_topics
    @topic = topics.select { |topic| topic.doc_id == @topic_id }.first
    @documents = Api::Document.all(@topic_id)
    @user_topic_subscriptions = TopicSubscription.where(user_id: cookies[:user_id])
  end

  def get_all_topics
    JSON.parse(Api::Topic.all)["topics"].map do |topic|
      topic['type'] = 'card'
      topic['stage'] = 'status: beslut'
      OpenStruct.new(topic)
    end
  end

  def verify_topic
    @topic_id = params[:id]
    bad_request('Missing `topic_id` parameter') if @topic_id.blank?
  end
end
