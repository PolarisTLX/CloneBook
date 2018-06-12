require 'rails_helper'

RSpec.describe RequestsController, type: :controller do

  let(:user) { create(:user) }
  let(:other_user) { create(:random_user) }
  let(:third_user) { create(:random_user) }

  context 'when user is logged in' do

    before do
      sign_in(user)
    end

    describe "GET #index" do
      it 'shows all friend requests page' do
          get :index
          expect(response).to have_http_status(:success)
      end
    end


    describe 'POST #create' do
        it 'clicking on "Add Friend" creates a new pending request' do
          expect { post :create, params: { request: { requester_id: user.id, requestee_id: other_user.id, accepted: 0 } }}.to change{Request.count}.by(1)
          expect(user.requestees).to include(other_user)
          expect(response).to redirect_to(root_url)
        end
    end


    describe 'PATCH #update' do
      it 'updates after requestee accepts the request and redirects to the requester\'s profile' do
          create(:request, requester_id: third_user.id, requestee_id: user.id)
          # third_user.sent_requests.create(requestee_id: user.id)
          expect { patch :update, params: { id: user.received_requests.where('requester_id = ?', third_user.id).first.id,
                                   request: { requester_id: third_user.id, requestee_id: user.id } } }.to change{user.friends.count}.by(1)
          expect(user.friends).to include(third_user)
          expect(response).to redirect_to(third_user.profile)
      end
    end

  end

  context 'when user is NOT logged in' do

    describe 'GET #index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'a new pending request is not created' do
        expect { post :create, params: { request: { requester_id: user.id, requestee_id: other_user.id, accepted: 0 } }}.to change{Request.count}.by(0)
        expect(user.requestees).to_not include(other_user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end


    describe 'PATCH #update' do
      it 'A friend request cannot be accepted' do
        create(:request, requester_id: third_user.id, requestee_id: user.id)

        expect { patch :update, params: { id: user.received_requests.where('requester_id = ?', third_user.id).first.id,
                                 request: { requester_id: third_user.id, requestee_id: user.id } } }.to change{user.friends.count}.by(0)
        expect(user.friends).to_not include(third_user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end


end
