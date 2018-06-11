require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    Rails.application.load_seed if User.count == 0
  end

  let(:post) { Post.first }

  it "is valid with content" do
    expect(post).to be_valid
  end

  it "is not valid without content" do
    post.content = '   '
    expect(post).to_not be_valid
  end

  it 'is not valid without a valid user_id' do
    post.user_id = 0
    expect(post).to_not be_valid
  end

end
