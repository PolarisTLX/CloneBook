class Profile < ApplicationRecord
  belongs_to :user

  # for paperclip for file attachment functionality:
  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100", tac: "30x30" }
  validates_attachment_content_type :avatar, content_type: ["image/jpg", "image/jpeg", "image/png"]
end