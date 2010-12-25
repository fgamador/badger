class ScoutsController < ApplicationController
  # GET /scouts
  # GET /scouts.xml
  def index
    @scouts = Scout.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @scouts }
    end
  end

  # GET /scouts/1
  # GET /scouts/1.xml
  def show
    @scout = Scout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @scout }
    end
  end

  # GET /scouts/new
  # GET /scouts/new.xml
  def new
    @scout = Scout.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @scout }
    end
  end

  # GET /scouts/1/edit
  def edit
    @scout = Scout.find(params[:id])
  end

  # POST /scouts
  # POST /scouts.xml
  def create
    @scout = Scout.new(params[:scout])

    respond_to do |format|
      if @scout.save
        format.html { redirect_to(@scout, :notice => 'Scout was successfully created.') }
        format.xml  { render :xml => @scout, :status => :created, :location => @scout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @scout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /scouts/1
  # PUT /scouts/1.xml
  def update
    @scout = Scout.find(params[:id])

    respond_to do |format|
      if @scout.update_attributes(params[:scout])
        format.html { redirect_to(@scout, :notice => 'Scout was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @scout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scouts/1
  # DELETE /scouts/1.xml
  def destroy
    @scout = Scout.find(params[:id])
    @scout.destroy

    respond_to do |format|
      format.html { redirect_to(scouts_url) }
      format.xml  { head :ok }
    end
  end
end
