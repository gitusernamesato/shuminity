class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_one_attached :image
  
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
  
end
