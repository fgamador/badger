class AwardsController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :authenticate_admin, :except => [:index, :show]
  before_filter :cache_session_vars
  before_filter :find_award, :only => [:show, :edit, :update, :destroy]

  def index
    @title = "Awards"
    @awards = Award.all.sort
  end

  def show
    @title = @award.name
  end

  def new
    @title = "New award"
    @award = Award.new
  end

  def edit
    @title = "Edit " + @award.name
  end

  def create
    if params[:cancel]
      redirect_to(awards_url)
      return
    end

    @award = Award.new(params[:award])
    if @award.save
      redir_url = params[:save_and_new] ? new_award_url : awards_url
      redirect_to(redir_url, :notice => "Award was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to(@award)
      return
    end

    if @award.update_attributes(params[:award])
      redirect_to(@award, :notice => "Award was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @award.destroy
    redirect_to(awards_url)
  end

  private

  def find_award
    @award = Award.find(params[:id])
  end
end

