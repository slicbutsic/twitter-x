class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :tweet, presence: true, length: { minimum: 5, maximum: 280 }
end
