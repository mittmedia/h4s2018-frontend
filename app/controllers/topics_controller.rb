class TopicsController < ApplicationController
  before_action :verify_topic, only: :show

  def index
    topics = get_all_topics
    @topics = insert_trending(topics)
    @user_topic_subscriptions = TopicSubscription.where(user_id: cookies[:user_id])
    @counties = Region.where(level: 0)
    @municipalities = Region.where(level: 1)
  end

  def show
    topics = get_all_topics
    @topic = topics.select { |topic| topic.doc_id == @topic_id }.first
    @documents = JSON.parse(Api::Document.all(@topic_id))
    doctypes = []
    @documents['documents'].each do |doc|
      doc_type = doc['document_type']
      doctypes.push('förslag') if doc_type === 'sou'
      doctypes.push('beredning') if doc_type === 'prop'
      doctypes.push('debatt') if doc_type === 'mot'
      doctypes.push('beslut') if doc_type === 'vot'
    end
    @doctypes = doctypes.uniq
    @user_topic_subscriptions = TopicSubscription.where(user_id: cookies[:user_id])
  end

  def get_all_topics
    topics = JSON.parse(Api::Topic.all)["topics"].map do |topic|
      topic['type'] = 'card'
      topic['stage'] = 'status: beslut'
      OpenStruct.new(topic)
    end.uniq(&:doc_id).sort { |x,y| y.published_at <=> x.published_at }
  end

  private

  def trending_topics(topics)
    limit = 3
    trending_dok_ids = TopicSubscription.trending
    trending_topics = topics.select do |topic|
      trending_dok_ids.include?(topic.doc_id)
    end
    trending_topics.take(limit)
  end

  def insert_trending(topics)
    tt = trending_topics(topics)
    return topics if tt.length == 0
    trending_doc_ids = tt.pluck(:doc_id)
    topics = filter_trending(topics, trending_doc_ids)
    order_feed(topics, tt)
  end

  def filter_trending(topics, trending_doc_ids)
    topics.reject { |topic| trending_doc_ids.include?(topic.doc_id) }
  end

  def order_feed(topics, tt)
    topics.insert(1, wrap_trending_topics(tt))
  end

  def wrap_trending_topics(tt)
    OpenStruct.new({
      type: 'trending',
      cards: tt
    })
  end

  def verify_topic
    @topic_id = params[:id]
    bad_request('Missing `topic_id` parameter') if @topic_id.blank?
  end
end
