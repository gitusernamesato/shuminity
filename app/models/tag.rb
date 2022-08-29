class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts,through: :post_tags

  validates :tagname, uniqueness: true, presence: true

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @Tag = Tag.where("tagname LIKE?", "#{word}")
    elsif search == "forward_match"
      @Tag = Tag.where("tagname LIKE?","#{word}%")
    elsif search == "backward_match"
      @Tag = Tag.where("tagname LIKE?","%#{word}")
    elsif search == "partial_match"
      @Tag = Tag.where("tagname LIKE?","%#{word}%")
    else
      @Tag = Tag.all
    end
  end
end
