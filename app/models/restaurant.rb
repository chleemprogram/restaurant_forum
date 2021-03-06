class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  #使用者收藏很多餐廳
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  #like
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def update_favorites_count
    self.increment!(:favorites_count)
  end

  def down_favorites_count
    self.decrement!(:favorites_count, 1)
  end
end
