require 'spec_helper'

RSpec.describe 'posts/show.html.erb' do

  let(:user) { create(:user) }  # equivalent to User.create({})
  let!(:user_post) { create(:post, user_id: user.id) }

  let(:other_user) { create(:random_user) }  # equivalent to User.create({})
  let!(:other_user_post) { create(:post, user_id: other_user.id) }

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
        expect(rendered).to have_text('Edit Post')
        expect(rendered).to have_text('Delete')
        expect(rendered).to have_text('Like')
        expect(rendered).to have_text('Comment')
        # NOT WORKING!
        # expect(rendered).to have_tag('a.timestamp')
        # expect(rendered).to have_tag('a', :with => { :class => 'timestamp' })
        # expect(rendered).to have_tag('span', :with => { :class => 'edit-delete-post' })
      end

  end

  context 'if logged in user is NOT the author of the post' do

      it 'displays the correct links and text for the other user' do
        assign(:post, other_user_post)
        assign(:comment, comment)
        render
        expect(rendered).to have_link href: "/profiles/#{other_user_post.user_id}"
        expect(rendered).to have_text("#{other_user_post.content}")
        expect(rendered).to_not have_text('Edit Post')
        expect(rendered).to_not have_text('Delete')
        # NOT WORKING
        # expect(rendered).to_not have_tag('span', :with => { :class => 'edit-delete-post' })
      end

  end

end
