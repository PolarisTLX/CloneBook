require 'spec_helper'

RSpec.describe 'posts/index.html.erb' do

  let(:user) { create(:user) }  # equivalent to User.create({})
  let(:user_post) { build(:post, user_id: user.id) }

  let(:comment) { build(:comment) }

  before do
    sign_in(user)
  end

      it 'displays the correct links and text' do
        assign(:post, Post.new)
        assign(:comment, comment)
        assign(:posts, user.posts.page(1))
        render
        expect(rendered).to have_link href: "/profiles/#{user.id}"
        expect(rendered).to have_text('Make Post')
        expect(rendered).to have_text('Photo')
        # NOT WORKING
        # expect(rendered).to have_placeholder("What&#39;s on your mind, #{user.first_name}?")
        # expect(rendered).to have_tag('textarea', :with => {:placeholder => 'on your mind'})
      end

end
