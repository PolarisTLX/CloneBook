require 'rails_helper'

RSpec.describe Request, type: :model do
  before do
    Rails.application.load_seed if User.count == 0
  end

  let(:request) { Request.first }
  let(:user) { User.first }
  let(:other_user) { User.where('id NOT IN (?)', user.friend_ids).second }

  it 'is valid with valid attributes' do
    expect(request).to be_valid
  end

  it 'is not valid without a valid requester_id' do
    request.requester_id = 0
    expect(request).to_not be_valid
  end

  it 'is not valid without a valid requestee_id' do
    request.requestee_id = 0
    expect(request).to_not be_valid
  end

  describe '#accept' do
    it 'updates the current request and creates a reciprocal accepted request' do
      @request = Request.create(requester_id: other_user.id, requestee_id: user.id)
      expect(@request.accepted).to eq(0)
      @request.accept
      expect(@request.accepted).to eq(1)
      expect(Request.last.requester_id).to eq(user.id)
      expect(Request.last.requestee_id).to eq(other_user.id)
      expect(Request.last.accepted).to eq(1)
    end
  end

  # def accept
  #   self.update_attributes(accepted: 1)
  #   Request.create!(requester_id: self.requestee_id,
  #                   requestee_id: self.requester_id,
  #                   accepted: 1)
  # end

end
