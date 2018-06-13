class LikesController < ApplicationController

  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      flash[:success] = 'You liked this post!'
      redirect_to root_url
    else
      flash[:danger] = 'Like did not work'
      redirect_to root_url
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to root_url
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end

end
