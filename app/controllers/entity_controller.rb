class @entityClasssController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :authenticate_admin, :except => [:index, :show]
  before_filter :cache_session_vars
  before_filter :find_entity, :only => [:show, :edit, :update, :destroy]

  def index
    @title = @upperLabel
    @entities = @entityClass.all.sort
  end

  def show
    @title = @entity.name
  end

  def new
    @title = "New " + @lowerLabel
    @entity = @entityClass.new
  end

  def edit
    @title = "Edit " + @entity.name
  end

  def create
    if params[:cancel]
      redirect_to(@entities_url)
      return
    end

    @entity = @entityClass.new(params[@entitySymbol])
    if @entity.save
      redir_url = params[:save_and_new] ? new_entity_url : entities_url
      redirect_to(redir_url, :notice => "#{@entityClass.name} was successfully created.")
    else
      render :action => "new"
    end
  end

  def update
    if params[:cancel]
      redirect_to(@entity)
      return
    end

    if @entity.update_attributes(params[@entitySymbol])
      redirect_to(@entity, :notice => "#{@entityClass.name} was successfully updated.")
    else
      render :action => "edit"
    end
  end

  def destroy
    @entity.destroy
    redirect_to(@entities_url)
  end

  private

  def find_entity
    @entity = @entityClass.find(params[:id])
  end
end

