class BadgerConfigsController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :authenticate_admin, :except => [:index, :show]
  before_filter :check_admin
  before_filter :find_scout, :only => [:show, :edit, :update]

  def show
    @title = @scout.name
  end

  def edit
    @title = "Edit " + @scout.name
  end

  def update
    if @scout.update_attributes(params[:scout])
      redirect_to(@scout, :notice => "Scout was successfully updated.")
    else
      render :action => "edit"
    end
  end

  private

  def find_scout
    @scout = Scout.find(params[:id])
  end
end

