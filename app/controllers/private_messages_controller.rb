class PrivateMessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user

  def index
    @private_messages = @user.messages.where("reply_id is null").order("coalesce(last_reply, created_at) desc")
  end

  def sent
    @private_messages = @user.sent_messages
  end

  def show
    @private_message = PrivateMessage.find(params[ :id])
    @replies = @private_message.replies.find(:all, order: 'created_at asc')
    @message = @private_message.new_reply
  end

  def new
    @message = @user.sent_messages.new
  end

  def create
    @message = @user.sent_messages.new(params[:private_message])
    if @message.save
      redirect_to user_private_messages_path(@user.id) , notice: "message sent"
    else
      render "new"
    end
  end

  def delete

  end

  def destroy
    #don't delete for both users :/ glhf
  end

#also what about sent messages?

private
  def load_user
    @user = User.find(params[:user_id])
  end

  def current_resource
    @current_resource ||= PrivateMessage.find(params[:id]) if params[:id]
  end
end

