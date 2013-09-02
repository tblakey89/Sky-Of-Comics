class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create]
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      track_activity @comment
      redirect_to @commentable, notice: "comment created"
    else
      render :new
    end
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def current_resource
    @current_resource ||= Comment.find(params[:id]) if params[:id]
  end
end
