require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:comment) { build(:comment) }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'is valid without content' do
    comment.content = '   '
    expect(comment).to be_valid
  end

  it 'is not valid without a valid post_id' do
    comment.post_id = 0
    expect(comment).to_not be_valid
  end

  it 'is not valid without a valid user_id' do
    comment.user_id = 0
    expect(comment).to_not be_valid
  end

end
