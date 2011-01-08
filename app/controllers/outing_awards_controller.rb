class OutingAwardsController < ApplicationController
  before_filter :authenticate_admin, :cache_session_vars, :find_outing
  before_filter :find_outing_award, :only => [:edit, :update, :destroy]

  def new
    @title = "Add award to " + @outing.name
    @outing_award = @outing.outing_awards.build
    @eligible_awards = Award.all(:order => "name") - @outing.awards
  end

  def edit
    @title = "Edit award for " + @outing.name
  end

  def create
    if params[:cancel]
      redirect_to @outing
      return
    end

    @outing_award = @outing.outing_awards.build(params[:outing_award])
    if @outing_award.save
      redir_url = params[:save_and_new] ? new_outing_outing_award_path(@outing) : @outing
      redirect_to redir_url, :notice => "Award was successfully added."
    else
      @eligible_awards = Award.all(:order => "name") -
        (@outing.awards - [ @outing_award.award ])
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to @outing
      return
    end

    if @outing_award.update_attributes(params[:outing_award])
      redirect_to @outing, :notice => "Award was successfully updated."
    else
      render :action => "edit"
    end
  end

  def destroy
    @outing_award.destroy
    redirect_to @outing
  end

  private

  def find_outing
    @outing = Outing.find(params[:outing_id])
  end

  def find_outing_award
    @outing_award = OutingAward.find(params[:id])
  end
end

