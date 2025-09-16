class RemoveTweetIdFromComments < ActiveRecord::Migration[7.2]
  def change
    remove_column :comments, :share_id, :integer
  end
end
