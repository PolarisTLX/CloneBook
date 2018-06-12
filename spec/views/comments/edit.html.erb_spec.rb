require 'spec_helper'

RSpec.describe 'comments/edit.html.erb' do

  let(:user) { create(:user) }  # equivalent to User.create({})
  let(:author) { create(:random_user) }
  let!(:author_post) { create(:post, user_id: author.id) }

  let!(:comment) { create(:comment, post_id: author_post.id, user_id: user.id) }

  before do
    sign_in(user)
  end

      it 'displays the correct links and text' do
        assign(:comment, comment)
        render
        expect(rendered).to have_text('Edit your comment on:')
        # expect post author link
        expect(rendered).to have_link href: "/profiles/#{author_post.user_id}"
        expect(rendered).to have_text("#{author_post.content}")
        # expect user link
        expect(rendered).to have_link href: "/profiles/#{user.id}"
      end

end
