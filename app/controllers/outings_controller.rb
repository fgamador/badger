class OutingsController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :authenticate_admin, :except => [:index, :show]
  before_filter :cache_session_vars
  before_filter :find_outing, :only => [:show, :edit, :update, :destroy]

  def index
    @title = "Outings"
    @outings = Outing.all(:order => "date DESC")
  end

  def show
    @title = @outing.name
  end

  def new
    @title = "New outing"
    @outing = Outing.new
  end

  def edit
    @title = "Edit " + @outing.name
  end

  def create
    if params[:cancel]
      redirect_to(outings_url)
      return
    end

    @outing = Outing.new(params[:outing])
    if @outing.save
      redir_url = params[:save_and_new] ? new_outing_url : outings_url
      redirect_to(redir_url, :notice => "Outing was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to(@outing)
      return
    end

    if @outing.update_attributes(params[:outing])
      redirect_to(@outing, :notice => "Outing was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @outing.destroy
    redirect_to(outings_url)
  end

  private

  def find_outing
    @outing = Outing.find(params[:id])
  end
end

