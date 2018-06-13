class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :github]

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one :profile, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :accepted_sent_requests, -> { where accepted: 1 }, foreign_key: :requester_id, class_name: 'Request'
  has_many :friends, through: :accepted_sent_requests, source: :requestee

  has_many :sent_requests, foreign_key: :requester_id, class_name: 'Request', dependent: :destroy
  has_many :received_requests, foreign_key: :requestee_id, class_name: 'Request', dependent: :destroy
  has_many :requestees, through: :sent_requests, dependent: :destroy
  has_many :requesters, through: :received_requests, dependent: :destroy

  after_create :make_profile


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?

      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(" ")[0]
      user.last_name = auth.info.name.split(" ")[1]
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def make_profile
    # This is for login with facebook or github
    self.create_profile.save

    # This is turned off temprorily to stop production of copies of missing.png during RSpec testing:
          # image_path = "#{Rails.root}/app/assets/images/missing.png"
          # image_file = File.new(image_path)
          #
          #
          # self.create_profile(:avatar => ActionDispatch::Http::UploadedFile.new(
          #   :filename => File.basename(image_file),
          #   :tempfile => image_file,
          #   # detect the image's mime type with MIME if you can't provide it yourself.
          #   :type => MIME::Types.type_for(image_path).first.content_type
          #   )
          # )
  end


end
