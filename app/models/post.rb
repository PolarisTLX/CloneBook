class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :content, presence: true

  # for paperclip for file attachment functionality:
  has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png"]

  default_scope -> { order(created_at: :desc) }
end
