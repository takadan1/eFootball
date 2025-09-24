class AddNewGoalsReasonsToMatches < ActiveRecord::Migration[7.2]
  def change
    add_column :matches, :gf_throughkuzusi, :integer, null: false, default: 0
    add_column :matches, :gf_corner, :integer, null: false, default: 0
    add_column :matches, :gf_fk, :integer, null: false, default: 0
    add_column :matches, :gf_pk, :integer, null: false, default: 0
    add_column :matches, :ga_throughkuzusi, :integer, null: false, default: 0
    add_column :matches, :ga_corner, :integer, null: false, default: 0
    add_column :matches, :ga_fk, :integer, null: false, default: 0
    add_column :matches, :ga_pk, :integer, null: false, default: 0
  end
end