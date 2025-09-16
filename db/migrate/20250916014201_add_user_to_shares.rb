class AddUserToShares < ActiveRecord::Migration[7.2]
  def change
    add_reference :shares, :user, null: true, foreign_key: true
  end
end
