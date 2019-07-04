class NovelContent < ApplicationRecord
	belongs_to :novel
	belongs_to :user

	has_many :comment, dependent: :destroy
	has_many :like, dependent: :destroy
	has_many :history, dependent: :destroy

	validates :novel_content_title, presence: true, {maximam: 50}
	validates :novel_content_text, presence: true, length: {maximam: 30000, minimum: 500}
end
