class RequestsController < ApplicationController
  def create
    @friend_request = current_user.sent_requests.build(friend_request_params)
    if @friend_request.save
      flash[:success] = 'Friend request sent!'
      redirect_to root_url
    else
      render root_url
    end
  end

  def update
    # @request = current_user.received_requests.find_by(requester_id: params[:request][:requester_id])
    @friend_request = Request.find(params[:id])
    @friend_request.update_columns(accepted: 1)
    flash[:success] = 'Friend Request Accepted!'
    redirect_to User.find(params[:request][:requester_id]).profile
  end

  def index
    @users = current_user.requesters.where('requests.accepted = ?', 0)
  end

  private

  def friend_request_params
    params.require(:request).permit(:requestee_id)
  end
end
