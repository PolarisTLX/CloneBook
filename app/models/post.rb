class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :content, presence: true
  # for paperclip for file attachment functionality:
  has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png"]

  default_scope -> { order(created_at: :desc) }

  scope :friends_posts, -> (current_user) { where('user_id IN (?) OR user_id = ?',
                                            current_user.friend_ids, current_user.id)
                                            .order(:created_at) }

end
