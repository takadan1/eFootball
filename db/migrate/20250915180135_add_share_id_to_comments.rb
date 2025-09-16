class AddShareIdToComments < ActiveRecord::Migration[7.2]
  def change
    add_column :comments, :share_id, :integer
  end
end
