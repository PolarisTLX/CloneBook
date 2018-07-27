require 'rails_helper'

RSpec.describe "profiles/show.html.erb", type: :view do

  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user_id: user.id) }

  let(:other_user) { create(:random_user) }

  let(:comment) { build(:comment) }

  before do
    sign_in(user)
  end

  context 'if user has no friends' do

    it 'displays the correct links and text' do
      # assign(:post, Post.new)
      assign(:comment, comment)
      assign(:posts, user.posts.page(1))
      assign(:profile, user.profile)
      render

      expect(rendered).to have_text("#{user.first_name} #{user.last_name}")

      expect(rendered).to have_text('Date of Birth:')
      expect(rendered).to_not have_text("#{user.first_name}'s friends:")

      expect(rendered).to have_link href: "/profiles/#{user.id}"
      expect(rendered).to have_text("#{user_post.content}")
      expect(rendered).to have_text('Edit Post')
      expect(rendered).to have_text('Delete')
      expect(rendered).to have_text('Like')
      expect(rendered).to have_text('Comment')
    end

  end



  context 'if user has friends' do

  let!(:friend) { create(:request, requestee_id:other_user.id, requester_id: user.id, accepted: 1) }

    it 'displays the correct links and text' do
      # assign(:post, Post.new)
      assign(:comment, comment)
      assign(:posts, user.posts.page(1))
      assign(:profile, user.profile)
      render

      expect(rendered).to have_text("#{user.first_name} #{user.last_name}")

      expect(rendered).to have_text('Date of Birth:')
      expect(rendered).to have_text("#{user.first_name}'s friends:")

      expect(rendered).to have_link href: "/profiles/#{other_user.id}"

      expect(rendered).to have_link href: "/profiles/#{user.id}"
      expect(rendered).to have_text("#{user_post.content}")
      expect(rendered).to have_text('Edit Post')
      expect(rendered).to have_text('Delete')
      expect(rendered).to have_text('Like')
      expect(rendered).to have_text('Comment')
    end

  end

end
