require 'spec_helper'

RSpec.describe 'posts/edit.html.erb' do

  let(:user) { create(:user) }  # equivalent to User.create({})
  let!(:user_post) { create(:post, user_id: user.id) }


  let(:comment) { build(:comment) }

  before do
    sign_in(user)
  end

  context 'if logged in user is the author of the post' do

      it 'displays the correct links and text' do
        assign(:post, user_post)
        assign(:comment, comment)
        render
        expect(rendered).to have_link href: "/profiles/#{user_post.user_id}"
        expect(rendered).to have_text("#{user_post.content}")
        expect(rendered).to have_text('Edit your post')
        expect(rendered).to have_text('Photo')
      end

  end

end
