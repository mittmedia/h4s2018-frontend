class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user

  def set_user
    user_id = cookies[:user_id] || params[:user_id]
    if user_id.blank?
      @user = User.create
    else
      @user = User.find(user_id)
    end
    cookies[:user_id] = @user.id
  end
end
