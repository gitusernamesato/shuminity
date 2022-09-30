class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags,through: :post_tags

  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true

  # image_tag post.getimage(w,h)で投稿画像の読み込み、サイズ調整
  def get_image(width, height)
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
   image.variant(resize_to_limit: [width, height]).processed
  end

  # ユーザIDがfavorite内に存在するか確認。viewの条件分岐で使用。
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tagname) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tagname: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tagname: new)
      self.tags << new_post_tag
   end
  end

   # 検索方法の分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?", "#{word}").where(is_hidden: false)
    elsif search == "forward_match"
      @post = Post.where("title LIKE?","#{word}%").where(is_hidden: false)
    elsif search == "backward_match"
      @post = Post.where("title LIKE?","%#{word}").where(is_hidden: false)
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%").where(is_hidden: false)
    else
      @post = Post.all
    end
  end
end
