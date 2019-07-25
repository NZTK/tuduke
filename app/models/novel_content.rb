class NovelContent < ApplicationRecord
  acts_as_paranoid
  is_impressionable counter_cache: true

  belongs_to :novel
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :history, dependent: :destroy

  validates :novel_content_title, presence: true, length: { maximum: 50 }
  validates :novel_content_text, presence: true, length: { maximum: 50000, minimum: 300 }
  validates :novel_content_forewords, length: { maximum: 500 }
  validates :novel_content_afterwords, length: { maximum: 500 }

  def previous
    # @novel_content =  NovelContent.find(params[:id])
    # NovelContent.where("id < ?", self.id).order(id: "DESC").first
    # binding.pry
    # if NovelContent.where('id < @novel_content.id  and  novel_id = @novel_content.novel.id').exists?
    #   @prev = NovelContent.where('id < @novel_content.id  and  novel_id = @novel_content.novel.id').max
    # end
    # @prev = NovelContent.where('id < @novel_content  and  novel_id = @novel_content.novel')
  end

  def next
    # NovelContent.where("id > ?", self.id).order(id: "ASC").first
    @next = NovelContent.where('id > @novelcontent.id  and  novel_id = @novelcontent.novel.id')
  end

  def liked_by?(user)
    likes.where(user_id: user_id).exists?
  end
end
