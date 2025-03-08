class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :tweet, presence: true, length: { minimum: 2, maximum: 140 }

  # Scope to get posts from followed users
  scope :from_followed_users, ->(user) {
    followed_user_ids = user.following.pluck(:id)
    where(user_id: followed_user_ids)
  }
end
