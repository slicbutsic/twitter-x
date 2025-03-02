class Post < ApplicationRecord
  belongs_to :user

  validates :tweet, presence: true, length: { minimum: 5, maximum: 280 }
end
