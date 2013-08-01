class BlogsController < ApplicationController
  before_filter :authenticate_user!, except: [ :index, :show]

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[ :id])
    @commentable = @blog
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(params[:blog])
    if @blog.save
      flash[:success] = "Blog created"
      redirect_to @blog
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
