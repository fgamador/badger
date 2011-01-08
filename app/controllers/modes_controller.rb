class ModesController < ApplicationController
  before_filter :authenticate, :only => [:show_inactive, :hide_inactive]
  before_filter :authenticate_admin, :except => [:show_inactive, :hide_inactive]

  def admin_mode
    set_admin_mode(true)
    redirect_to(:back)
  end

  def view_mode
    set_admin_mode(false)
    redirect_to(:back)
  end

  def show_inactive
    set_show_inactive(true)
    redirect_to(:back)
  end

  def hide_inactive
    set_show_inactive(false)
    redirect_to(:back)
  end
end

