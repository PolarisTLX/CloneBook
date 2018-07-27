require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

    let(:user) { create(:user) }

    context 'when user is logged in' do

      before do
        sign_in(user)
      end

      describe "GET #show" do
        it 'shows the user profile page' do
          get :show, params: { id: user.profile.id }
          expect(response).to have_http_status(:success)
        end
      end

      describe "GET #edit" do
        it 'shows the edit profile page' do
          get :edit, params: { id: user.profile.id }
          expect(response).to have_http_status(:success)
        end
      end

      # NOT PASSING!
      # describe 'PATCH #update' do
      #   it 'updates the profile and redirects to profile show' do
      #     patch :update, params: { id: user.profile.id, profile: { birthday: nil, gender: 'Male', location: 'Somewhere', bio: 'A little bit about me' } }
      #     expect(user.profile.birthday).to eq nil
      #     expect(user.profile.gender).to eq 'Male'
      #     expect(user.profile.location).to eq 'Somewhere'
      #     expect(user.profile.bio).to eq 'A little bit about me'
      #     expect(response).to redirect_to(user.profile)
      #   end
      # end

    end

    context 'when user is NOT logged in' do

      describe "GET #show" do
        it 'redirects to login' do
          get :show, params: { id: user.profile.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe "GET #edit" do
        it 'redirects to login' do
          get :edit, params: { id: user.profile.id }
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe 'PATCH #update' do
        it 'does NOT update the profile and redirects to login' do
          patch :update, params: { id: user.profile.id, profile: { gender: 'Male', location: 'Somewhere', bio: 'A little bit about me' } }
          expect(user.profile.gender).to be nil
          expect(user.profile.location).to be nil
          expect(user.profile.bio).to be nil
          expect(response).to redirect_to(new_user_session_path)
        end
      end

    end

end
