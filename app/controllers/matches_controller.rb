class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  def index
    @matches = current_user.matches.order(created_at: :desc)
  end

  def new
    @match = current_user.matches.new
  end

  def create
    @match = current_user.matches.new(match_params)
    if @match.save
      redirect_to matches_path, notice: "記録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end
  def edit; end

  def update
    if @match.update(match_params)
      redirect_to @match, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @match.destroy
    redirect_to matches_path, notice: "削除しました"
  end

  private
  def set_match
    @match = current_user.matches.find(params[:id])
  end

  def match_params
    params.require(:match).permit(
      :result, :opponent_formation, :team_style, :notes,
      :gf_counter, :gf_cross, :gf_one_two, :gf_long_shot, :gf_throughpass,
      :gf_dribble, :gf_build_up, :gf_accident, :gf_other,
      :ga_counter, :ga_cross, :ga_one_two, :ga_long_shot, :ga_throughpass,
      :ga_dribble, :ga_build_up, :ga_accident, :ga_other
    )
  end
end
