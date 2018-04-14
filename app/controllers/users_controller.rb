class UsersController < ApplicationController
  before_action :set_user, only: [
    :destroy,
    :subscribe,
    :regions_subscribed_to,
    :subscribe_to_region,
    :unsubscribe_from_region,
    :topics_subscribed_to,
    :subscribe_to_topic,
    :unsubscribe_from_topic
  ]
  before_action :set_region, only: [:subscribe_to_region, :unsubscribe_from_region]

  # TODO: This clearly can't be okay.
  skip_before_action :verify_authenticity_token, only: [
    :register_notifications,
    :subscribe_to_region,
    :unsubscribe_from_region,
    :subscribe_to_topic,
    :unsubscribe_from_topic,
  ]

  # POST /users
  # POST /users.json
  def create
    return redirect_to topics_path if cookies[:user_id].present?
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        cookies[:user_id] = @user.id
        format.html { redirect_to topics_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # REGIONS

  # GET /users/1/regions_subscribed_to.json
  def regions_subscribed_to
    respond_to do |format|
      format.json { render json: @user.regions_subscribed_to }
    end

  end

  # PUT /users/1/subscribe_to_region.json
  def subscribe_to_region
    respond_to do |format|
      if @user.subscribe_to_region(@region)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1/unsubscribe_from_region.json
  def unsubscribe_from_region
    respond_to do |format|
      if @user.unsubscribe_from_region(@region)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # TOPICS

  # GET /users/1/topics_subscribed_to.json
  def topics_subscribed_to
    respond_to do |format|
      format.json { render json: @user.topics_subscribed_to }
    end

  end

  # PUT /users/1/subscribe_to_topic.json
  def subscribe_to_topic
    respond_to do |format|
      if @user.subscribe_to_topic(params[:topic_id])
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1/unsubscribe_from_topic.json
  def unsubscribe_from_topic
    respond_to do |format|
      if @user.unsubscribe_from_topic(params[:topic_id])
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users/1/subscribe.json
  def register_notifications
    respond_to do |format|
      if @user.update(subscription: user_params.fetch(:subscription).to_json)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(cookies[:user_id] || params[:user_id])
    end

    def set_region
      @region = Region.find(params[:region_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
