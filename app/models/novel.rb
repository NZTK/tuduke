class Novel < ApplicationRecord
	acts_as_paranoid
	is_impressionable counter_cathe: true
	acts_as_taggable

	belongs_to :user
	belongs_to :genre

	has_many :novel_content

	validates :novel_title, presence: true, length: {maximum: 50, minimum:  3}
	validates :novel_about, presence: true, length: {maximum: 500, minimum: 10}
end
