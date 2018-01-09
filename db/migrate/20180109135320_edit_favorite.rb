class EditFavorite < ActiveRecord::Migration[5.1]
  def change
    add_column :favorites, :use_id, :integer
    add_column :favorites, :restaurant_id, :integer
  end
end
