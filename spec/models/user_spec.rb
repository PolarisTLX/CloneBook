require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  context 'is not valid without a first name' do
    it 'first name is nil' do
      user.first_name = nil
      expect(user).to_not be_valid
    end
  end

  context 'is not valid without a last name' do
    it 'last name is nil' do
      user.last_name = nil
      expect(user).to_not be_valid
    end
  end

  context 'is not valid without a valid email' do
    it 'email is nil' do
      user.email = nil
      expect(user).to_not be_valid
    end
    it 'is missing an "@"' do
      user.email = 'kyle.email.com'
      expect(user).to_not be_valid
    end
    it 'is missing a "."' do
      user.email = 'kyle@email'
      expect(user).to_not be_valid
    end
  end

  context "is not valid without a valid password" do
    it 'is too short' do
      user.password = 'passwor'
      expect(user).to_not be_valid
    end
    it 'is too long' do
      user.password = 'a'*129
      expect(user).to_not be_valid
    end
  end

  describe '#make_profile' do
    it 'creates a profile after a new user is created' do
      user.save
      expect(user.profile).to_not be nil
    end
  end
end
