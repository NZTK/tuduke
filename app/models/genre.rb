class Genre < ApplicationRecord
	has_many :novel
	validates :genre_name, presence: true
end
