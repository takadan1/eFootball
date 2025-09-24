class AddOpponentRankToMatches < ActiveRecord::Migration[7.2]
  def change
    add_column :matches, :opponent_rank, :integer
  end
end