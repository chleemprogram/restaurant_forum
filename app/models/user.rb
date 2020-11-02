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

  def admin?
    self.role == "admin"
  end
end
