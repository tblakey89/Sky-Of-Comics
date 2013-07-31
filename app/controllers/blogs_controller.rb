class BlogsController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show]

  def index
    @blogs = Blog.all
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
end
