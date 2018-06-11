require 'rails_helper'

RSpec.describe RequestsController, type: :controller do

  before(:all) do
    Rails.application.load_seed if User.count == 0
  end

  let(:user) { User.first }
  let(:other_user) { User.where('id NOT IN (?)', user.friend_ids).first }
  let(:third_user) { User.where('id NOT IN (?)', user.friend_ids).second }

  # before(:all) do
  #   third_user.sent_requests.create(requestee_id: user.id)
  # end

  context 'when user is logged in' do

    before do
      sign_in(user)
    end


    describe 'POST #create' do

      describe 'when new friend request is sent' do
        it 'creates a new pending request' do
          expect { post :create, params: { request: { requester_id: user.id, requestee_id: other_user.id, accepted: 0 } }}.to change{Request.count}.by(1)
          expect(user.requestees).to include(other_user)
          expect(response).to redirect_to(root_url)
        end
      end

      # describe 'when new post does not have any content' do
      #   it 'does NOT create a new post' do
      #     expect{post :create, params: { post: { content: ''} }}.to change{Post.count}.by(0)
      #   end
      # end

    end


  #
    describe 'PATCH #update' do
      it 'updates after requestee accepts the request and redirects to ...' do
          third_user.sent_requests.create(requestee_id: user.id)
          expect { patch :update, params: { id: user.received_requests.where('requester_id = ?', third_user.id).first.id,
                                   request: { requester_id: third_user.id, requestee_id: user.id } } }.to change{user.friends.count}.by(1)
          expect(user.friends).to include(third_user)
      end
    end
  #
  #
  # end
  #
  # context 'when user is NOT logged in' do
  #

  #
  #   describe 'PATCH #update' do
  #     it 'does NOT update the profile and redirects to login' do
  #       patch :update, params: { id: user.id, profile: { gender: 'Male', location: 'Somewhere', bio: 'A little bit about me' } }
  #       expect(user.profile.gender).to be nil
  #       expect(user.profile.location).to be nil
  #       expect(user.profile.bio).to be nil
  #       expect(response).to redirect_to(new_user_session_path)
  #     end
  #   end
  end



end
