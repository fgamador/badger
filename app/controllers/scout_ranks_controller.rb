class ScoutRanksController < ApplicationController
  before_filter :authenticate_admin, :cache_session_vars, :find_scout
  before_filter :find_scout_rank, :only => [:edit, :update, :destroy]

  def new
    @title = "Add rank to " + @scout.name
    @scout_rank = @scout.scout_ranks.build
    @eligible_ranks = Rank.all(:order => "ordinal") - @scout.ranks
    @scout_rank.rank = @scout.next_rank
  end

  def edit
    @title = "Edit rank for " + @scout.name
  end

  def create
    if params[:cancel]
      redirect_to @scout
      return
    end

    @scout_rank = @scout.scout_ranks.build(params[:scout_rank])
    if @scout_rank.save
      redir_url = params[:save_and_new] ? new_scout_scout_rank_path(@scout) : @scout
      redirect_to redir_url, :notice => "Rank was successfully added."
    else
      @eligible_ranks = Rank.all(:order => "ordinal") -
        (@scout.ranks - [ @scout_rank.rank ])
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to @scout
      return
    end

    if @scout_rank.update_attributes(params[:scout_rank])
      redirect_to @scout, :notice => "Rank was successfully updated."
    else
      render :action => "edit"
    end
  end

  def destroy
    @scout_rank.destroy
    redirect_to @scout
  end

  private

  def find_scout
    @scout = Scout.find(params[:scout_id])
  end

  def find_scout_rank
    @scout_rank = ScoutRank.find(params[:id])
  end
end

