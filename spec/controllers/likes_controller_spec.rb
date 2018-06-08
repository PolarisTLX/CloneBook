require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  before(:all) do
    Rails.application.load_seed if User.count == 0
    User.last.likes.create(post_id: 1) if User.last.likes.count == 0
  end

  let(:user) { User.last }
  let(:other_user_post) { User.first.posts.first }
  let(:like) { user.likes.first }

  context 'when user is logged in' do

    before do
      sign_in(user)
    end

    describe 'POST #create' do

      describe 'when user has not already liked a post' do
        it 'creates the new like' do
          expect{post :create, params: { like: { post_id: other_user_post.id} }}.to change{Like.count}.by(1)
          expect(other_user_post.likes.first.user_id).to eq user.id
          expect(response).to redirect_to(root_url)
        end
      end

      describe 'when user has already liked a post' do
        it 'does NOT create a new like' do
          post :create, params: { like: { post_id: other_user_post.id} }

          expect{post :create, params: { like: { post_id: other_user_post.id} }}.to change{Like.count}.by(0)
        end
      end

    end

    describe 'DELETE #destroy' do
      it 'deletes the like' do
        expect { delete :destroy, params: { id: like.id } }.to change{Like.count}.by(-1)
        expect(response).to redirect_to(root_url)
      end
    end
  end

  context 'when user is not logged in' do

    describe 'POST #create' do
      it 'does not create like and redirects to login' do
          expect{post :create, params: { like: { post_id: other_user_post.id} }}.to change{Like.count}.by(0)
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
