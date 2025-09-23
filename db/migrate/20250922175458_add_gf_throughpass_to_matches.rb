class AddGfThroughpassToMatches < ActiveRecord::Migration[7.2]
  def change
    add_column :matches, :gf_throughpass, :integer, null: false, default: 0
    add_column :matches, :ga_throughpass, :integer, null: false, default: 0
  end
end
