class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :tweet, presence: true, length: { minimum: 5, maximum: 280 }
end
