class Profile < ApplicationRecord
  belongs_to :user

  # for paperclip for file attachment functionality:
  has_attached_file :avatar, styles: { medium: "175x175#", thumb: "100x100#", tac: "20x20#" },
                             default_url: ActionController::Base.helpers.image_path("missing.png")
  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png"]

  has_attached_file :cover, styles: { large: "851x358#" }
  validates_attachment_content_type :cover, content_type: ["image/jpg", "image/jpeg", "image/png"]

  def profile_photo
    if self.avatar.exists?
      self.avatar.url
    else
      self.user.image
    end
  end

end
