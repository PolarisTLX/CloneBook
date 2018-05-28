class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = current_user.posts.build(post_params)
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
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.delete
    flash[:success] = "Post successfully deleted."
    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
