class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  #user 下有評論,就不能刪除(會拋出error)
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  #user收藏很多餐廳,多對多
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  mount_uploader :avatar, AvatarUploader
  def admin?
    self.role == "admin"
  end
end
