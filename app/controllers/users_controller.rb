class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [ :following, :followers ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[ :id])
  end

  def following
    @title = "Following"
    @user = User.find(params[ :user_id])
    @users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[ :user_id])
    @users = @user.followers
    render 'show_follow'
  end
end
