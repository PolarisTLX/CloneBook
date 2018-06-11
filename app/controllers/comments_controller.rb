class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'Comment posted'
      redirect_to Post.find(@comment.post_id)
    else
      flash[:danger] = 'Comment not posted'
      redirect_to root_url
    end
  end

  def edit
    comment
  end

  def update
    if comment.update_attributes(comment_params)
      flash[:success] = "Comment updated!"
      redirect_to Post.find(comment.post_id)
    else
      render 'edit'
    end
  end

  def destroy
    comment.destroy
    flash[:success] = "Comment successfully deleted."
    redirect_to root_url
  end
  private

  def comment
      @comment ||= Comment.find(params[:id])
  end
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
