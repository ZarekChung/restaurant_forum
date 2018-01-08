class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
  belongs_to :category
  #關聯資料刪除,當restaurant被刪除一起刪除關聯的評論
  has_many :comments, dependent: :destroy 
end
