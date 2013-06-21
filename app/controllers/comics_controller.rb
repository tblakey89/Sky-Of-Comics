class ComicsController < ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create, :update, :destroy ]

  def index

  end

  def show
    @comic = Comic.find(params[ :id])
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = current_user.comics.build(params[:comic])
    if @comic.save
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
end
