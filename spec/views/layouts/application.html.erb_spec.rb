require 'spec_helper'

RSpec.describe 'layouts/application.html.erb' do

# FACTORY BOT METHOD instead of seeds
  let(:user) { create(:user) }  # equivalent to User.create({})

  context 'when the user is logged in' do

    before do
      sign_in(user)
    end

    it 'displays the name and "Log out" in the navbar' do
      render
      expect(rendered).to have_text('All Users')
      expect(rendered).to have_text(user.first_name)
      expect(rendered).to have_text('Edit Account')
      expect(rendered).to have_text('Home')
      expect(rendered).to have_text('Sign Out')
    end

  end

  context 'when the user is NOT logged in' do

    it 'does NOT display "Home" and "All Users" in the navbar' do
      render
      expect(rendered).to_not have_text('All Users')
      expect(rendered).to_not have_text('Edit Account')
      expect(rendered).to_not have_text('Home')
      expect(rendered).to_not have_text('Sign Out')
    end

  end

end
