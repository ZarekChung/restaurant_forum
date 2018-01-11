class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  belongs_to :category
  #關聯資料刪除,當restaurant被刪除一起刪除關聯的評論
  has_many :comments, dependent: :destroy 
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  def is_favorited?(user)
    self.favorited_users.include?(user)    
  end

  def is_liked?(user)
    self.liked_users.include?(user)
  end

  def count_favorites
    self.favorites_count = self.favorites.size
    self.save
  end

end
