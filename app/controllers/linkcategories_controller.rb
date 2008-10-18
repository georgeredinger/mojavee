class LinkcategoriesController < ApplicationController
      before_filter :login_required
  # GET /linkcategories
  # GET /linkcategories.xml
  def index
    @linkcategories = Linkcategory.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @linkcategories }
    end
  end

  # GET /linkcategories/1
  # GET /linkcategories/1.xml
  def show
    @linkcategory = Linkcategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @linkcategory }
    end
  end

  # GET /linkcategories/new
  # GET /linkcategories/new.xml
  def new
    @linkcategory = Linkcategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @linkcategory }
    end
  end

  # GET /linkcategories/1/edit
  def edit
    @linkcategory = Linkcategory.find(params[:id])
  end

  # POST /linkcategories
  # POST /linkcategories.xml
  def create
    @linkcategory = Linkcategory.new(params[:linkcategory])

    respond_to do |format|
      if @linkcategory.save
        flash[:notice] = 'Linkcategory was successfully created.'
        format.html { redirect_to(@linkcategory) }
        format.xml  { render :xml => @linkcategory, :status => :created, :location => @linkcategory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @linkcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /linkcategories/1
  # PUT /linkcategories/1.xml
  def update
    @linkcategory = Linkcategory.find(params[:id])

    respond_to do |format|
      if @linkcategory.update_attributes(params[:linkcategory])
        flash[:notice] = 'Linkcategory was successfully updated.'
        format.html { redirect_to(@linkcategory) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @linkcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /linkcategories/1
  # DELETE /linkcategories/1.xml
  def destroy
    @linkcategory = Linkcategory.find(params[:id])
    @linkcategory.destroy

    respond_to do |format|
      format.html { redirect_to(linkcategories_url) }
      format.xml  { head :ok }
    end
  end
end
