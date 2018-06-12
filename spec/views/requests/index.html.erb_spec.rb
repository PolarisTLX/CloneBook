require 'rails_helper'

RSpec.describe "requests/index.html.erb", type: :view do

  let(:user) { create(:user) }
  let(:other_user) { create(:random_user) }
  let!(:friend_request) { create(:request, requester_id:other_user.id, requestee_id: user.id) }

  before do
    sign_in(user)
  end

      it 'displays the correct links and text' do
        # assign(:posts, user.posts.page(1))
        assign(:users, user.requesters.where('requests.accepted = ?', 0))
        render
        expect(rendered).to have_link href: "/profiles/#{other_user.id}"
        expect(rendered).to have_text('Friend Requests')
      end

end
