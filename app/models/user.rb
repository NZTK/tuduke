class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :novel ,dependent: :destroy
         has_many :novel_content
         has_many :history, dependent: :destroy
         has_many :like, dependent: :destroy
         has_many :comment

         has_many :active_relationships, class_name: "Relationship",
         								foreign_key: "follower_id",
         								dependent: :destroy
         has_many :passive_relationships, class_name:  "Relationship",
			         					 foreign_key: "follower_id",
			         					 dependent: :destroy

         validates :user_name, presence: true, uniqueness: true, length: {maximum: 15, minimum: 3}




         def follow(other_user)
         	active_relationships.create(followed_id: other_user.id)
         end
         def unfollow(other_user)
         	passive_relationships.find_by(followed_id: other_user.id).destroy
         end
         def following?(other_user)
         	following.include?(other_user)
         end


end
