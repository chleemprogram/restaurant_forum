class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :restrict_with_exception
  has_many :restaurants, through: :comments
  mount_uploader :avatar, AvatarUploader
  validates_presence_of :name

  def admin?
    self.role == "admin"
  end
end
