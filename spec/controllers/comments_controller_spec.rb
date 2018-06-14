require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user_id: user.id) }
  let!(:user_comment) { create(:comment, user_id: user.id, post_id: user_post.id) }

  context 'when user is logged in' do

    before do
      sign_in(user)
    end

    describe 'POST #create' do
        it 'creates the new comment' do
          expect{post :create, params: { comment: { content: 'This is my first comment!', post_id: user_post.id } }}.to change{Comment.count}.by(1)
          expect(Comment.last.content).to eq 'This is my first comment!'
          expect(response).to redirect_to(Post.find(user_post.id))
        end
    end

    describe 'GET #edit' do
        it 'shows the edit comment page' do
            get :edit, params: { id: user_comment.id }
            expect(response).to have_http_status(:success)
        end
    end

    describe 'PATCH #update' do
        it 'updates the comment' do
          patch :update, params: { id: user_comment.id, comment: { content: 'Editing my first comment!'} }
          expect(user.comments.first.content).to eq 'Editing my first comment!'
          expect(response).to redirect_to(user.comments.first.post)
        end
    end

    describe 'DELETE #destroy' do
      it 'deletes the comment' do
        expect { delete :destroy, params: { id: user_comment.id } }.to change{Comment.count}.by(-1)
        expect(response).to redirect_to(root_url)
      end
    end
  end

  context 'when user is not logged in' do

    describe 'POST #create' do
      it 'does not create comment and redirects to login' do
          expect{post :create, params: { comment: { content: 'I am trying to make a comment!', post_id: user_post.id } }}.to change{Comment.count}.by(0)
          expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
          get :edit, params: { id: user_comment.id }
          expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #update' do
      it 'does not edit the comment and redirects to login' do
        patch :update, params: { id: user_comment.id, comment: { content: 'Editing my first comment!'} }
        expect(user.comments.first.content).to_not eq 'Editing my first comment!'
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'does NOT delete the comment and redirects to login' do
        expect { delete :destroy, params: { id: user_comment.id } }.to change{Comment.count}.by(0)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

end
