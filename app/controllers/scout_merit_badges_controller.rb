class ScoutMeritBadgesController < ApplicationController
  before_filter :authenticate_admin, :cache_session_vars, :find_scout
  before_filter :find_scout_merit_badge, :only => [:edit, :update, :destroy]

  def new
    @title = "Add merit badge to " + @scout.name
    @scout_merit_badge = @scout.scout_merit_badges.build
    @eligible_merit_badges = MeritBadge.all(:order => "name") - @scout.merit_badges
  end

  def edit
    @title = "Edit merit badge for " + @scout.name
  end

  def create
    if params[:cancel]
      redirect_to(@scout)
      return
    end

    @scout_merit_badge = @scout.scout_merit_badges.build(params[:scout_merit_badge])
    if @scout_merit_badge.save
      redir_url = params[:save_and_new] ? new_scout_merit_badge_url : @scout
      redirect_to(redir_url, :notice => "Merit badge was successfully added.")
    else
      @eligible_merit_badges = MeritBadge.all(:order => "name") -
        (@scout.merit_badges - [ @scout_merit_badge.merit_badge ])
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to(@scout)
      return
    end

    if @scout_merit_badge.update_attributes(params[:scout_merit_badge])
      redirect_to(@scout, :notice => "Merit badge was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @scout_merit_badge.destroy
    redirect_to(@scout)
  end

  private

  def find_scout
    @scout = Scout.find(params[:scout_id])
  end

  def find_scout_merit_badge
    @scout_merit_badge = ScoutMeritBadge.find(params[:id])
  end
end

