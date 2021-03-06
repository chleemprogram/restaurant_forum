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

  #follower
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  #friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  #friends who add me
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :add_me_friends, through: :inverse_friendships, source: :user


  def admin?
    self.role == "admin"
  end

  def like_this_restaurant?(restaurant)
    self.liked_restaurants.include?(restaurant)
  end

  def following?(user)
    self.followings.include?(user)
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def all_friends
    (self.friends + self.add_me_friends).uniq
  end
end
