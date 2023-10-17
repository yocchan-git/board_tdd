class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {maximum: 40}
  validates :content, presence: true, length: {maximum: 250}
end
