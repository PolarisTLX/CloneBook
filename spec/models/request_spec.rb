require 'rails_helper'

RSpec.describe Request, type: :model do

  let(:user) { create(:user) }
  let(:other_user) { create(:random_user) }
  let(:request) { build(:request, requester_id: user.id, requestee_id: other_user.id) }

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
      request.save
      expect(request.accepted).to eq(0)
      request.accept
      expect(request.accepted).to eq(1)
      expect(Request.last.requester_id).to eq(other_user.id)
      expect(Request.last.requestee_id).to eq(user.id)
      expect(Request.last.accepted).to eq(1)
    end
  end
  
end
