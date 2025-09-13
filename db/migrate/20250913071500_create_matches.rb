class CreateMatches < ActiveRecord::Migration[7.2]
  def change
    create_table :matches do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :result, null: false, default: 0
      t.string  :opponent_formation
      t.integer :team_style
      t.text    :notes

      %i[
        gf_counter gf_cross gf_one_two gf_long_shot gf_dribble gf_build_up gf_accident gf_other
        ga_counter ga_cross ga_one_two ga_long_shot ga_dribble ga_build_up ga_accident ga_other
      ].each do |col|
        t.integer col, null: false, default: 0
      end

      t.timestamps
    end
  end
end
