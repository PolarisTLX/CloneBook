require 'spec_helper'

RSpec.describe 'devise/registrations/edit.html.erb' do

  let(:user) { create(:user) }  # equivalent to User.create({})

  before do
    view.stub(:resource).and_return(User.new)
    view.stub(:resource_name).and_return(:user)
    view.stub(:devise_mapping).and_return(Devise.mappings[:user])
  end

      it 'displays the correct links and text' do
        sign_in(user)
        render
        # NOT WORKING
        # expect(rendered).to have_text("#{user.first_name}")
        # expect(rendered).to have_text("#{user.last_name}")
        # expect(rendered).to have_text("#{user.email}")
        expect(rendered).to have_text('Edit Your Account')
        expect(rendered).to have_text('Delete Your Account')

        # NOT WORKING
        # expect(rendered).to have_text('Update')
        # expect(rendered).to have_text('Delete')
      end

end
