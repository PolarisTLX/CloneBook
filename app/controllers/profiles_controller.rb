class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params[:id])
    @posts = @profile.user.posts.page(params[:page]).per(5)
    @comment = Comment.new
  end

  def edit
    @profile = current_user.profile
  end

  def update
    if profile.update_attributes(profile_params)
      flash[:success] = "Your profile has been updated"
      redirect_to profile
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:birthday, :gender, :location, :bio, :avatar, :cover)
  end

  def profile
    @profile ||= Profile.find(params[:id])
  end

end
