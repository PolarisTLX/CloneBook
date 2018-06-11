require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    Rails.application.load_seed if User.count == 0
  end

  let(:profile) { Profile.first }

  it "is valid with content" do
    profile.birthday = '1988-12-25'
    profile.location = 'Indianapolis'
    profile.gender = 'Male'
    profile.bio = 'Some text that may or may not be true'
    expect(profile).to be_valid
  end

  it "is not valid with a birthday in the future" do
    profile.birthday = '4515-02-28'
    expect(profile).to_not be_valid
  end

  it "is not valid with a gender that has too many characters" do
    profile.gender = 'qwert' * 20 + 'y'
    expect(profile).to_not be_valid
  end

  it "is not valid with a location that has too many characters" do
    profile.location = 'qwert' * 51 + 'y'
    expect(profile).to_not be_valid
  end

  it "is not valid with a bio that has too many characters" do
    profile.bio = 'qwert' * 400 + 'y'
    expect(profile).to_not be_valid
  end

end
