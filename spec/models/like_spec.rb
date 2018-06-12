require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:like) { build(:like) }

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
    like.save
    @like = build(:like)
    expect(@like).to_not be_valid
  end
end
