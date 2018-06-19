class UsersController < ApplicationController

  def index
    # @users = User.all
    @users = User.where('id != ?' , current_user.id).order(first_name: 'asc').page(params[:page]).per(12)
  end

end
