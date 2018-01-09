class EditFavoriteUserid < ActiveRecord::Migration[5.1]
  def change
    rename_column :favorites, :use_id, :user_id
  end
end
