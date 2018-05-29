class ProfilesController < ApplicationController

  def show
    @profile = Profile.find(params[:id])
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
    params.require(:profile).permit(:birthday, :gender, :location, :bio, :avatar)
  end

  def profile
    @profile ||= Profile.find(params[:id])
  end

end
