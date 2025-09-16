class SharesController < ApplicationController

  before_action :authorize_user!, only: [:edit, :update, :destroy]

    def index
        @shares = Share.all.includes(:user).order(created_at: :desc)
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

  def show
    @share = Share.find(params[:id])
    @comments = @share.comments.includes(:user)
    @comment = Comment.new
  end

   def edit
    @share = Share.find(params[:id])
  end

   def update
    @share = Share.find(params[:id])
    if @share.update(share_params)
      redirect_to @share, notice: '投稿が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end


   def destroy
    share = Share.find(params[:id])
    share.destroy
    redirect_to shares_path, notice: '投稿が削除されました。'
  end

  private
  def share_params
    params.require(:share).permit(:photo, :about, :image)
  end

   def authorize_user!
    @share = Share.find(params[:id])
    unless @share.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to root_path 
   end
  end
end

