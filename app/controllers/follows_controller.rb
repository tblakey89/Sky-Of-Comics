class FollowsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def create
    @user = User.find_by_id(params[:follow][:followed_id])
    if @user and @user != current_user
      current_user.follow!(@user)
      track_activity @user
      track_activity current_user, "followed", @user
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      redirect_to current_user
    end
  end

  def destroy
    @user = Follow.find_by_id(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
