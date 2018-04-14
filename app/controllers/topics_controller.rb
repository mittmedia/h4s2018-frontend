class TopicsController < ApplicationController
  before_action :verify_topic, only: :show

  def index
<<<<<<< HEAD
    @topics = get_all_topics
=======
    @topics = JSON.parse(Api::Topic.all)["topics"].map do |topic|
      topic['type'] = 'card'
      topic['stage'] = 'status: beslut'
      OpenStruct.new(topic)
    end.uniq!(&:doc_id)
    # insert_trending!

>>>>>>> Fixes and trending work
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
    end.uniq!(&:doc_id)
  end

  private

  def insert_trending!
    trending = TopicSubscription.trending
    trending.map!{ |trendy_id| @topics.delete_if { |topic| trending.include?(topic.id) } }
    trending_container = OpenStruct.new({
      type: 'trending',
      cards: trending.flatten
    })
    new_topics = [@topics.delete_at(0), trending_container]
    @topics = new_topics << @topics
  end

  def verify_topic
    @topic_id = params[:id]
    bad_request('Missing `topic_id` parameter') if @topic_id.blank?
  end
end
