require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:user) { create(:user) }
  let(:post) { build(:post, user_id: user.id) }

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
