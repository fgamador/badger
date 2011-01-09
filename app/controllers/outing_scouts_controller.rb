class OutingScoutsController < ApplicationController
  before_filter :authenticate_admin, :cache_session_vars, :find_outing
  before_filter :find_outing_scout, :only => [:edit, :update, :destroy]

  def new
    @title = "Add scout to " + @outing.name
    @outing_scout = @outing.outing_scouts.build
    @outing_scout.nights_of_camping = @outing.nights_of_camping
    # TODO active only
    @eligible_scouts = Scout.all.sort - @outing.scouts
  end

  def edit
    @title = "Edit scout for " + @outing.name
  end

  def create
    if params[:cancel]
      redirect_to @outing
      return
    end

    @outing_scout = @outing.outing_scouts.build(params[:outing_scout])
    if @outing_scout.save
      court_of_honor = params[:court_of_honor_id] ? CourtOfHonor.find(params[:court_of_honor_id]) : nil

      if params[:award_ids]
        params[:award_ids].each do |id|
          @outing_scout.scout.add_award :award => Award.find(id), :earned => @outing_scout.outing.date,
            :outing_scout => @outing_scout, :court_of_honor => court_of_honor
        end
      end

      @outing_scout.scout.num_new_ten_noc_awards.times do
        @outing_scout.scout.add_award :award => Award.ten_nights_of_camping, :earned => @outing_scout.outing.date,
          :outing_scout => @outing_scout, :court_of_honor => court_of_honor
      end

      redir_url = params[:save_and_new] ? new_outing_outing_scout_path(@outing) : @outing
      redirect_to redir_url, :notice => "Scout was successfully added."
    else
      @eligible_scouts = Scout.all.sort - (@outing.scouts - [ @outing_scout.scout ])
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to @outing
      return
    end

    if @outing_scout.update_attributes(params[:outing_scout])
      redirect_to @outing, :notice => "Scout was successfully updated."
    else
      render :action => "edit"
    end
  end

  def destroy
    @outing_scout.destroy
    redirect_to @outing
  end

  private

  def find_outing
    @outing = Outing.find(params[:outing_id])
  end

  def find_outing_scout
    @outing_scout = OutingScout.find(params[:id])
  end
end

