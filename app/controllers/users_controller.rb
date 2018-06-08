class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    # @users = User.all
    @users = User.where('id != ?' , current_user.id).page(params[:page]).per(12)
  end

end
