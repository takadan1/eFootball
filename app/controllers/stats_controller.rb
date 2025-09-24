class StatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @formation = params[:formation].presence
    @style     = params[:style].presence
    @keyword   = params[:keyword].presence # 検索キーワード
    @rank      = params[:rank].presence

    rel = current_user.matches
    rel = rel.by_formation(@formation) if @formation
    rel = rel.by_team_style(@style)    if @style
    rel = rel.by_keyword(@keyword)     if @keyword 
    rel = rel.by_opponent_rank(@rank)  if @rank 

    @total = rel.count
    if @total.zero?
      @win_pct = @draw_pct = @loss_pct = 0.0
      @avg_gf = @avg_ga = 0.0
      @top_gf_reasons = []
      @top_ga_reasons = []
      return
    end

    # 勝敗%
    @win_pct  = (rel.result_win.count * 100.0 / @total).round(1)
    @draw_pct = (rel.result_draw.count * 100.0 / @total).round(1)
    @loss_pct = (rel.result_loss.count * 100.0 / @total).round(1)

    # 平均得点数・平均失点数
    gf_expr = "gf_throughpass + gf_throughkuzusi + gf_counter + gf_cross + gf_one_two + gf_long_shot + gf_dribble + gf_build_up + gf_accident +  gf_corner + gf_fk + gf_pk + gf_other"
    ga_expr = "ga_throughpass + ga_throughkuzusi + ga_counter + ga_cross + ga_one_two + ga_long_shot + ga_dribble + ga_build_up + ga_accident +  ga_corner + ga_fk + ga_pk + ga_other"
    @avg_gf = rel.average(Arel.sql(gf_expr)).to_f.round(2)
    @avg_ga = rel.average(Arel.sql(ga_expr)).to_f.round(2)

    # 得点・失点理由のトップ3を計算し、ビューに渡す
    gf_sums = Match::GF_REASONS.keys.map { |key| [key, rel.sum(key)] }.to_h
    ga_sums = Match::GA_REASONS.keys.map { |key| [key, rel.sum(key)] }.to_h

    # 得点理由のトップ3を計算し、インスタンス変数に格納
    sorted_gf_reasons = gf_sums.sort_by { |_, v| -v }.to_h
    total_gf = sorted_gf_reasons.values.sum
    @top_gf_reasons = sorted_gf_reasons.take(3).map.with_index(1) do |(key, count), index|
      percentage = total_gf.positive? ? ((count * 100.0) / total_gf).round(1) : 0.0
      { rank: index, name: Match::GF_REASONS[key], count: count, percentage: percentage }
    end

    # 失点理由のトップ3を計算し、インスタンス変数に格納
    sorted_ga_reasons = ga_sums.sort_by { |_, v| -v }.to_h
    total_ga = sorted_ga_reasons.values.sum
    @top_ga_reasons = sorted_ga_reasons.take(3).map.with_index(1) do |(key, count), index|
      percentage = total_ga.positive? ? ((count * 100.0) / total_ga).round(1) : 0.0
      { rank: index, name: Match::GA_REASONS[key], count: count, percentage: percentage }
    end
  end
end