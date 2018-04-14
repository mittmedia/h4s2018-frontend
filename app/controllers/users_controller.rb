class UsersController < ApplicationController
  before_action :set_user, only: [:destroy, :subscribe]
  skip_before_action :verify_authenticity_token, only: [:subscribe]

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

  # POST /users/1/subscribe.json
  def subscribe
    respond_to do |format|
      if @user.update(subscription: user_params.fetch(:subscription).to_json)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(cookies[:user_id] || params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end
end
