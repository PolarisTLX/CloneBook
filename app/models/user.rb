class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  # has_many :profiles
  has_many :posts
  has_many :comments
  has_many :likes

  after_create :make_profile

  private

  def make_profile
    # Profile.create(user_id: self.id)

    # profile = self.build_profile
    # profile.save

    self.create_profile

    # self.profiles.create
  end
end
