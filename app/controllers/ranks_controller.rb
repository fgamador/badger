class RanksController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :authenticate_admin, :except => [:index, :show]
  before_filter :cache_session_vars
  before_filter :find_rank, :only => [:show, :edit, :update, :destroy]

  def index
    @title = "Ranks"
    @ranks = Rank.all.sort
  end

  def show
    @title = @rank.name
  end

  def new
    @title = "New rank"
    @rank = Rank.new
    @rank.ordinal = Rank.count
  end

  def edit
    @title = "Edit " + @rank.name
  end

  def create
    if params[:cancel]
      redirect_to(ranks_url)
      return
    end

    @rank = Rank.new(params[:rank])
    if @rank.save
      redir_url = params[:save_and_new] ? new_rank_url : ranks_url
      redirect_to(redir_url, :notice => "Rank was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to(@rank)
      return
    end

    if @rank.update_attributes(params[:rank])
      redirect_to(@rank, :notice => "Rank was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @rank.destroy
    redirect_to(ranks_url)
  end

  private

  def find_rank
    @rank = Rank.find(params[:id])
  end
end

