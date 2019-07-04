class Relationship < ApplicationRecord
belongs_to :follower_id, Class_name: "User"
belongs_to :followed_id, Class_name: "User"

validates :follower_id, presence: true
validates :followed_id, presence: true

end
