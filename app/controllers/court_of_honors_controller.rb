class CourtOfHonorsController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :authenticate_admin, :except => [:index, :show]
  before_filter :cache_session_vars
  before_filter :find_court_of_honor, :only => [:show, :edit, :update, :destroy]

  def index
    @title = "Courts of Honor"
    @court_of_honors = CourtOfHonor.all(:order => "date DESC")
  end

  def show
    @title = @court_of_honor.name
    gather_ranks
    gather_merit_badges
    gather_awards
  end

  def new
    @title = "New Court of Honor"
    @court_of_honor = CourtOfHonor.new
  end

  def edit
    @title = "Edit " + @court_of_honor.name
  end

  def create
    if params[:cancel]
      redirect_to(court_of_honors_url)
      return
    end

    @court_of_honor = CourtOfHonor.new(params[:court_of_honor])
    if @court_of_honor.save
      redir_url = params[:save_and_new] ? new_court_of_honor_url : court_of_honors_url
      redirect_to(redir_url, :notice => "Court of Honor was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to(@court_of_honor)
      return
    end

    if @court_of_honor.update_attributes(params[:court_of_honor])
      redirect_to(@court_of_honor, :notice => "Court of Honor was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @court_of_honor.destroy
    redirect_to(court_of_honors_url)
  end

  private

  def gather_ranks
    @scouts_by_rank = {}
    @court_of_honor.scout_ranks.each do |sr|
      add_to_array @scouts_by_rank, sr.rank, sr.scout
    end

    @ranks = []
    @scouts_by_rank.each do |rank,scouts|
      @ranks << rank
      scouts.sort!
    end

    @ranks.sort!
  end

  def gather_merit_badges
    @scouts_by_merit_badge = {}
    @court_of_honor.scout_merit_badges.each do |smb|
      add_to_array @scouts_by_merit_badge, smb.merit_badge, smb.scout
    end

    @merit_badges = []
    @scouts_by_merit_badge.each do |merit_badge,scouts|
      @merit_badges << merit_badge
      scouts.sort!
    end

    @merit_badges.sort!
  end

  def gather_awards
    @scout_counts_by_award = {}
    @court_of_honor.scout_awards.each do |sa|
      add_to_counts @scout_counts_by_award, sa.award, sa.scout
    end

    @awards = @scout_counts_by_award.keys.sort!
  end

  def add_to_array(hash, key, element)
    (hash[key] || hash[key] = []) << element
  end

  def add_to_counts(hash, key, element)
    counts = hash[key] || hash[key] = {}
    count = counts[element] || 0
    counts[element] = count + 1
  end

  def find_court_of_honor
    @court_of_honor = CourtOfHonor.find(params[:id])
  end
end

