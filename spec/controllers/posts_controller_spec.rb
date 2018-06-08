require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  before do
    Rails.application.load_seed
  end

  let(:user) { User.first }
  let(:post_id) { user.posts.first.id }

  context 'when user is logged in' do

  before do
    sign_in(user)
  end

    describe "GET #index" do
      it 'successfully shows the timeline index page' do
          get :index
          expect(response).to have_http_status(:success)
      end
    end

    describe 'POST #create' do

      describe 'when new post info is valid' do
        it 'creates the new post' do
          expect{post :create, params: { post: { content: 'This is my first post!'} }}.to change{Post.count}.by(1)
          expect(Post.first.content).to eq 'This is my first post!'
          expect(response).to redirect_to(root_url)
        end
      end

      describe 'when new post does not have any content' do
        it 'does NOT create a new post' do
          expect{post :create, params: { post: { content: ''} }}.to change{Post.count}.by(0)
        end
      end

    end

    describe 'GET #edit' do

      it 'successfully brings user to edit post page' do
          get :edit, params: { id: post_id }
          expect(response).to have_http_status(:success)
      end

    end


    describe 'POST #update' do

      describe 'when edit post info is valid' do
        it 'edits the post' do
          patch :update, params: { id: post_id, post: { content: 'Editing my first post!'} }
          expect(user.posts.first.content).to eq 'Editing my first post!'
          expect(response).to redirect_to(user.posts.first)
        end
      end

      describe 'when edited post does not have any content' do
        it 'does NOT edit the post' do
          patch :update, params: { id: post_id, post: { content: ''} }
          expect(user.posts.first.content).to_not eq ''
        end
      end

    end

  end

  context 'when user is not logged in' do

    describe 'GET #index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'post is not created and user is redirected to login page' do
          expect{post :create, params: { post: { content: 'I am trying to make a post!'} }}.to change{Post.count}.by(0)
          expect(response).to redirect_to(new_user_session_path)
      end
    end

  end


end
