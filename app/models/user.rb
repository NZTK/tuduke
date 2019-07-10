class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :novels ,dependent: :destroy
         has_many :novel_contents
         has_many :histories, dependent: :destroy
         has_many :likes, dependent: :destroy
         has_many :comments

         validates :username, presence: true, uniqueness: true, length: {maximum: 15, minimum: 3}




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
