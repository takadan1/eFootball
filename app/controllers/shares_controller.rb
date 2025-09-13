class SharesController < ApplicationController

    def index
        @shares = Share.all
    end

 def new
    @share = Share.new
  end

  def create
    share = Share.new(share_params)
    if share.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @share = Share.find(params[:id])
  end

   def edit
    @share = Share.find(params[:id])
  end

   def update
    share = Share.find(params[:id])
    if share.update(share_params)
      redirect_to :action => "show", :id => share.id
    else
      redirect_to :action => "new"
    end
  end

   def destroy
    share = Share.find(params[:id])
    share.destroy
    redirect_to action: :index
  end

  private
  def share_params
    params.require(:share).permit(:photo, :about)
  end

end
