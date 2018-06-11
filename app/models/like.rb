class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  default_scope -> { order(created_at: :desc) }

  validates :user_id, uniqueness: { scope: :post_id }
end
