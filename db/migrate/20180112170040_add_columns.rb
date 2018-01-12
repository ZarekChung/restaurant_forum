class AddColumns < ActiveRecord::Migration[5.1]
    def change
      add_column :followships, :user_id, :integer
      add_column :followships, :following_id, :integer
  end
end
