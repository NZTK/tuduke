class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :novel_content
  validates :comment_contents, presence: true
end
