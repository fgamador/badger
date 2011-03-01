class MeritBadgesController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :authenticate_admin, :except => [:index, :show]
  before_filter :cache_session_vars
  before_filter :find_merit_badge, :only => [:show, :edit, :update, :destroy]

  def index
    @title = "Merit badges"
    @merit_badges = MeritBadge.find_active.sort
  end

  def show
    @title = @merit_badge.name
  end

  def new
    @title = "New merit_badge"
    @merit_badge = MeritBadge.new
  end

  def edit
    @title = "Edit " + @merit_badge.name
  end

  def create
    if params[:cancel]
      redirect_to(merit_badges_url)
      return
    end

    @merit_badge = MeritBadge.new(params[:merit_badge])
    if @merit_badge.save
      redir_url = params[:save_and_new] ? new_merit_badge_url : merit_badges_url
      redirect_to(redir_url, :notice => "Merit badge was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to(@merit_badge)
      return
    end

    if @merit_badge.update_attributes(params[:merit_badge])
      redirect_to(@merit_badge, :notice => "Merit badge was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @merit_badge.destroy
    redirect_to(merit_badges_url)
  end

  private

  def find_merit_badge
    @merit_badge = MeritBadge.find(params[:id])
  end
end

