class ImagesController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show]

  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[ :id])
    @commentable = @image
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @image = Image.new
  end

  def create
    @image = current_user.images.build(params[:image])
    if @image.save
      track_activity @image
      flash[:success] = "Image created"
      redirect_to @image
    else
      render 'new'
    end
  end

  def update

  end

  def delete

  end

  def destroy

  end
end
