class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.where('user_id IN (?) OR user_id = ?', current_user.friend_ids,
                        current_user.id).order(:created_at).page(params[:page]).per(5)
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:post_success] = 'Post successful!'
      redirect_to root_url
    else
      flash[:post_failure] = 'Post did not save - text content required.'
      redirect_to root_url
    end
  end

  def edit
    post
  end

  def update
    if post.update_attributes(post_params)
      flash[:success] = "Post updated!"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def show
    post
    @comment = Comment.new
  end

  def destroy
    post.destroy
    flash[:success] = "Post successfully deleted."
    redirect_to root_url
  end

  private

  def post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
