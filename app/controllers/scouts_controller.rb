class ScoutsController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :authenticate_admin, :except => [:index, :show]
  before_filter :check_admin_mode
  before_filter :find_scout, :only => [:show, :edit, :update, :destroy]

  def index
    @title = "Scouts"
    @scouts = Scout.all.sort
  end

  def show
    @title = @scout.name
  end

  def new
    @title = "New scout"
    @scout = Scout.new
  end

  def edit
    @title = "Edit " + @scout.name
  end

  def create
    if params[:cancel]
      redirect_to(scouts_url)
      return
    end

    @scout = Scout.new(params[:scout])
    if @scout.save
      redir_url = params[:save_and_new] ? new_scout_url : scouts_url
      redirect_to(redir_url, :notice => "Scout was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to(@scout)
      return
    end

    if @scout.update_attributes(params[:scout])
      redirect_to(@scout, :notice => "Scout was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @scout.destroy
    redirect_to(scouts_url)
  end

  def admin_mode
    set_admin_mode(true)
    redirect_to(scouts_url)
  end

  def view_mode
    set_admin_mode(false)
    redirect_to(scouts_url)
  end

  private

  def find_scout
    @scout = Scout.find(params[:id])
  end
end

