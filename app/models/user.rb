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

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  #新增一組user to following_id的foreign_key
  has_many :inverse_followships, class_name: "Followship" , foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  #friendship
  has_many :friendships, dependent: :destroy
  has_many :friend, through: :friendships

  #新增一組user to firend_id的foreign_key
  has_many :inverse_friends, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friended, through: :inverse_friends, source: :user

  mount_uploader :avatar, AvatarUploader
  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)    
  end

  def is_firend?(user)
    self.friend.include?(user)    
  end

  def all_friends
    (self.friend + self.friended).uniq
  end


end
