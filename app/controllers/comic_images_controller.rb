class ComicImagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_comic

  def new
    @comic_image = @comic.comic_images.new
  end

  def create
    @comic_image = @comic.comic_images.new(params[:comic_image])
    if @comic_image.save
      redirect_to @comic, notice: "Page Added"
    else
      render :new
    end
  end

  def update

  end

  def delete

  end

  def destroy

  end
private

  def load_comic
    @comic = Comic.find(params[:comic_id])
  end
end
