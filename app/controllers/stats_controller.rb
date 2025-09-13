class StatsController < ApplicationController
  before_action :authenticate_user!

  def index
    @formation = params[:formation].presence
    @style     = params[:style].presence

    rel = current_user.matches
    rel = rel.by_formation(@formation) if @formation
    rel = rel.by_team_style(@style)     if @style

    @total = rel.count
    if @total.zero?
      @win_pct = @draw_pct = @loss_pct = 0.0
      @avg_gf = @avg_ga = 0.0
      @top_ga_reason = @top_ga_pct = @top_gf_reason = @top_gf_pct = "-"
      return
    end

    # 勝敗%
    @win_pct  = (rel.result_win.count  * 100.0 / @total).round(1)
    @draw_pct = (rel.result_draw.count * 100.0 / @total).round(1)
    @loss_pct = (rel.result_loss.count * 100.0 / @total).round(1)

    # 平均得点数・平均失点数
    gf_expr = "gf_counter + gf_cross + gf_one_two + gf_long_shot + gf_dribble + gf_build_up + gf_accident + gf_other"
    ga_expr = "ga_counter + ga_cross + ga_one_two + ga_long_shot + ga_dribble + ga_build_up + ga_accident + ga_other"
    @avg_gf = rel.average(Arel.sql(gf_expr)).to_f.round(2)
    @avg_ga = rel.average(Arel.sql(ga_expr)).to_f.round(2)

    # 最頻理由と%
    ga_sums = {
      ga_counter: rel.sum(:ga_counter), ga_cross: rel.sum(:ga_cross), ga_one_two: rel.sum(:ga_one_two),
      ga_long_shot: rel.sum(:ga_long_shot), ga_dribble: rel.sum(:ga_dribble), ga_build_up: rel.sum(:ga_build_up),
      ga_accident: rel.sum(:ga_accident), ga_other: rel.sum(:ga_other)
    }
    gf_sums = {
      gf_counter: rel.sum(:gf_counter), gf_cross: rel.sum(:gf_cross), gf_one_two: rel.sum(:gf_one_two),
      gf_long_shot: rel.sum(:gf_long_shot), gf_dribble: rel.sum(:gf_dribble), gf_build_up: rel.sum(:gf_build_up),
      gf_accident: rel.sum(:gf_accident), gf_other: rel.sum(:gf_other)
    }

    total_ga = ga_sums.values.sum
    total_gf = gf_sums.values.sum

    if total_ga.positive?
      key_ga, max_ga = ga_sums.max_by { |_, v| v }
      @top_ga_reason = Match::GA_REASONS[key_ga]
      @top_ga_pct    = ((max_ga * 100.0) / total_ga).round(1)
    else
      @top_ga_reason = "-"
      @top_ga_pct    = 0.0
    end

    if total_gf.positive?
      key_gf, max_gf = gf_sums.max_by { |_, v| v }
      @top_gf_reason = Match::GF_REASONS[key_gf]
      @top_gf_pct    = ((max_gf * 100.0) / total_gf).round(1)
    else
      @top_gf_reason = "-"
      @top_gf_pct    = 0.0
    end
  end
end
