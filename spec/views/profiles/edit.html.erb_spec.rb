require 'rails_helper'

RSpec.describe "profiles/edit.html.erb", type: :view do

  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

    it 'displays the correct links and text' do
      assign(:profile, user.profile)
      render

      expect(rendered).to have_text("#{user.first_name} #{user.last_name}")

      expect(rendered).to have_text('Birthday')
      expect(rendered).to have_text('Gender')
      expect(rendered).to have_text('City')
      expect(rendered).to have_text('About Me')

    end

end
