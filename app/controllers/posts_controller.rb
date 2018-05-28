class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = Post.new(user_id: current_user.id, content: params[:post][:content])
    if @post.save
      flash[:post_success] = 'Post successful!'
      redirect_to root_url
    else
      render 'index'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(content: params[:post][:content])
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
