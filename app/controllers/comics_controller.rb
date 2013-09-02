class ComicsController < ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create, :update, :destroy ]

  def index
    @comics = Comic.all
  end

  def show
    @comic = Comic.find(params[ :id])
    @commentable = @comic
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = current_user.comics.build(params[:comic])
    if @comic.save
      track_activity @comic
      flash[:success] = "Comic Created"
      redirect_to @comic
    else
      render "new"
    end
  end

  def update

  end

  def destroy

  end

  def current_resource
    if params[:comic_id]
      @current_resource ||= Comic.find(params[:comic_id])
    else
      @current_resource ||= Comic.find(params[:id]) if params[:id]
    end
  end
end
