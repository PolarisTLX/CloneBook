require 'spec_helper'

RSpec.describe 'devise/registrations/new.html.erb' do

  before do
    view.stub(:resource).and_return(User.new)
    view.stub(:resource_name).and_return(:user)
    view.stub(:devise_mapping).and_return(Devise.mappings[:user])
  end

    it 'displays "clonebook" in the navbar' do
      render
      expect(rendered).to have_text('clonebook')
      expect(rendered).to have_text('Create a New Account')
      expect(rendered).to have_text('External Logins')
      expect(rendered).to have_text('Sign Up')
    end

end
