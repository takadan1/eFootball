class Match < ApplicationRecord
 belongs_to :user
 enum :result, { win: 0, draw: 1, loss: 2 }, prefix: true
 enum :team_style, {
  short_counter: 0, # ショートカウンター
  long_counter: 1,  # ロングカウンター
  possession: 2,   # ポゼッション
  long_ball: 3,   # ロングボール
  side_attack: 4   # サイドアタック
 }, prefix: true
 with_options inclusion: { in: 0..4 } do
  validates :gf_counter, :gf_cross, :gf_one_two, :gf_long_shot,
       :gf_dribble, :gf_build_up, :gf_accident, :gf_other,
       :ga_counter, :ga_cross, :ga_one_two, :ga_long_shot,
       :ga_dribble, :ga_build_up, :ga_accident, :ga_other
 end
 validates :result, presence: true
 def goals_for
  gf_counter + gf_cross + gf_one_two + gf_long_shot + gf_dribble + gf_build_up + gf_accident + gf_other
 end
 def goals_against
  ga_counter + ga_cross + ga_one_two + ga_long_shot + ga_dribble + ga_build_up + ga_accident + ga_other
 end
 scope :by_formation, ->(code) { where(opponent_formation: code) if code.present? }
 scope :by_team_style, ->(style) { where(team_style: team_styles[style]) if style.present? }
 GF_REASONS = {
  gf_counter: "カウンター", gf_cross: "クロス", gf_one_two: "ワンツー", gf_long_shot: "ミドルシュート",
  gf_dribble: "ドリブル", gf_build_up: "パス回し", gf_accident: "事故", gf_other: "その他"
 }.freeze
 GA_REASONS = {
  ga_counter: "カウンター", ga_cross: "クロス", ga_one_two: "ワンツー", ga_long_shot: "ミドルシュート",
  ga_dribble: "ドリブル", ga_build_up: "パス回し", ga_accident: "事故", ga_other: "その他"
 }.freeze
end