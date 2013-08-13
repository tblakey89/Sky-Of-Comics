class PrivateMessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user

  def index
    @messages = @user.messages
  end

  def show

  end

  def new

  end

  def create

  end

  def update

  end

  def delete

  end

  def destroy

  end

private
  def load_user
    @user = User.find(params[:user_id])
  end
end

