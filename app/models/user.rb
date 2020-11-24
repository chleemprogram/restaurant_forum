class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :restrict_with_exception
  has_many :restaurants, through: :comments
  #使用者收藏很多餐廳
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  mount_uploader :avatar, AvatarUploader
  validates_presence_of :name

  #like
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  #following
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  def admin?
    self.role == "admin"
  end

  def like_this_restaurant?(restaurant)
    self.liked_restaurants.include?(restaurant)
  end
end
