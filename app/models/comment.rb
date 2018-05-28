class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  default_scope -> { order(created_at: :asc) }
end
