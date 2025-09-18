# app/controllers/shares_controller.rb

class SharesController < ApplicationController
  # ログインしていないユーザーは、:index と :show 以外のアクションから弾く
  before_action :authenticate_user!, except: [:index, :show]

  # :show, :edit, :update, :destroy の前に @share をセットする
  before_action :set_share, only: [:show, :edit, :update, :destroy]

  # :edit, :update, :destroy の前に権限をチェックする
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @shares = Share.all.includes(:user).order(created_at: :desc)
  end

  def show
    # @share は before_action でセット済み
    @comments = @share.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @share = Share.new
  end

  def create
    @share = current_user.shares.build(share_params)
    if @share.save
      redirect_to shares_path, notice: '投稿が作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @share は before_action でセット済み
  end

  def update
    # @share は before_action でセット済み
    if @share.update(share_params)
      redirect_to @share, notice: '投稿が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @share は before_action でセット済み
    @share.destroy
    redirect_to shares_path, notice: '投稿を削除しました。', status: :see_other
  end

  private

  def set_share
    @share = Share.find(params[:id])
  end

  def share_params
    # :photo は使っていますか？ 不要であれば削除してください
    params.require(:share).permit(:photo, :about, :image)
  end

  # ★★★ これが最終版の権限チェックメソッド ★★★
  def authorize_user!
    # 投稿の所有者でもなく、かつ管理者でもない場合
    unless @share.user == current_user || current_user.admin?
      flash[:alert] = "あなたにはこの操作を行う権限がありません。"
      redirect_to root_path
    end
  end
end
