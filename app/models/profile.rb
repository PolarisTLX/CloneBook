class Profile < ApplicationRecord
  belongs_to :user

  # for paperclip for file attachment functionality:
  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#", tac: "20x20#" },
  default_url: '/images/:attachment/:style/missing.png'

  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png"]

  def profile_photo
    if self.avatar.exists?
      self.avatar.url
    else
      self.user.image
    end
  end

end
