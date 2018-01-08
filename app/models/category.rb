class Category < ApplicationRecord
  validates_presence_of :name
  #分類下有餐廳不能刪除,會拋出錯誤不會成功,但程式繼續執行
  has_many :restaurants, dependent: :restrict_with_error
end
