class BadgerConfigsController < ApplicationController
  before_filter :authenticate_admin
  before_filter :find_badger_config

  def edit
    @title = "Edit configuration"
  end

  def update
    if @badger_config.update_attributes(params[:badger_config])
      flash[:notice] = "Configuration was successfully updated."
    end
    render :action => "edit"
  end

  private

  def find_badger_config
    @badger_config = BadgerConfig.find(params[:id])
  end
end

