require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    Rails.application.load_seed if User.count == 0
  end

  let(:like) { Like.first }

  it 'is valid with valid attributes' do
    expect(like).to be_valid
  end

  it 'is not valid without a valid post_id' do
    like.post_id = 0
    expect(like).to_not be_valid
  end

  it 'is not valid without a valid user_id' do
    like.user_id = 0
    expect(like).to_not be_valid
  end

  it 'cannot like a post twice' do
    @like = Like.new(post_id: like.post_id, user_id: like.user_id)
    expect(@like).to_not be_valid
  end
end
