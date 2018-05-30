class RequestsController < ApplicationController
  def create
    @request = current_user.sent_requests.build(request_params)
    if @request.save
      flash[:success] = 'Friend request sent!'
      redirect_to root_url
    else
      render root_url
    end
  end

  private

  def request_params
    params.require(:request).permit(:requestee_id)
  end
end
