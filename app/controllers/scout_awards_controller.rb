class ScoutAwardsController < ApplicationController
  before_filter :authenticate_admin, :cache_session_vars, :find_scout
  before_filter :find_scout_award, :only => [:edit, :update, :destroy]

  def new
    @title = "Add award to " + @scout.name
    @scout_award = @scout.scout_awards.build
    @eligible_awards = Award.all(:order => "name") - @scout.one_per_scout_awards
  end

  def edit
    @title = "Edit award for " + @scout.name
  end

  def create
    if params[:cancel]
      redirect_to @scout
      return
    end

    @scout_award = @scout.scout_awards.build(params[:scout_award])
    if @scout_award.save
      redir_url = params[:save_and_new] ? new_scout_scout_award_path(@scout) : @scout
      redirect_to redir_url, :notice => "Award was successfully added."
    else
      @eligible_awards = Award.all(:order => "name") -
        (@scout.one_per_scout_awards - [ @scout_award.award ])
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to @scout
      return
    end

    if @scout_award.update_attributes(params[:scout_award])
      redirect_to @scout, :notice => "Award was successfully updated."
    else
      render :action => "edit"
    end
  end

  def destroy
    @scout_award.destroy
    redirect_to @scout
  end

  private

  def find_scout
    @scout = Scout.find(params[:scout_id])
  end

  def find_scout_award
    @scout_award = ScoutAward.find(params[:id])
  end
end

