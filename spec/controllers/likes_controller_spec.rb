require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  let(:user) { create(:user) }
  let(:other_user) { create(:random_user) }
  let!(:other_user_post1) { create(:post, user_id: other_user.id) }
  let!(:other_user_post2) { create(:post, user_id: other_user.id) }
  let!(:like) { create(:like, user_id: user.id, post_id: other_user_post2.id) }

  context 'when user is logged in' do

    before do
      sign_in(user)
    end

    describe 'POST #create' do

      describe 'when user has not already liked a post' do
        it 'creates the new like' do
          expect{post :create, params: { like: { post_id: other_user_post1.id} }}.to change{Like.count}.by(1)
          expect(other_user_post1.likes.first.user_id).to eq user.id
          expect(response).to redirect_to(root_url)
        end
      end

      describe 'when user has already liked a post' do
        it 'does NOT create a new like' do
          post :create, params: { like: { post_id: other_user_post2.id} }

          expect{post :create, params: { like: { post_id: other_user_post2.id} }}.to change{Like.count}.by(0)
        end
      end

    end

    describe 'DELETE #destroy' do
      it 'deletes the like to unlike post' do
        expect { delete :destroy, params: { id: like.id } }.to change{Like.count}.by(-1)
        expect(response).to redirect_to(root_url)
      end
    end
  end

  context 'when user is not logged in' do

    describe 'POST #create' do
      it 'does not create like and redirects to login' do
          expect{post :create, params: { like: { post_id: other_user_post1.id} }}.to change{Like.count}.by(0)
          expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'does NOT delete the post and redirects to login' do
        expect { delete :destroy, params: { id: like.id } }.to change{Like.count}.by(0)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

end
