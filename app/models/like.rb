class Like < ApplicationRecord
  belongs_to :user
  belongs_to :novel_content
end
