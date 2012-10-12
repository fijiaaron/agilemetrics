class OpenDefectsController < ApplicationController
  # GET /open_defects
  # GET /open_defects.json
  def index
    @open_defects = OpenDefect.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @open_defects }
    end
  end

  # GET /open_defects/1
  # GET /open_defects/1.json
  def show
    @open_defect = OpenDefect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @open_defect }
    end
  end

  # GET /open_defects/new
  # GET /open_defects/new.json
  def new
    @open_defect = OpenDefect.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @open_defect }
    end
  end

  # GET /open_defects/1/edit
  def edit
    @open_defect = OpenDefect.find(params[:id])
  end

  # POST /open_defects
  # POST /open_defects.json
  def create
    @open_defect = OpenDefect.new(params[:open_defect])

    respond_to do |format|
      if @open_defect.save
        format.html { redirect_to @open_defect, notice: 'Open defect was successfully created.' }
        format.json { render json: @open_defect, status: :created, location: @open_defect }
      else
        format.html { render action: "new" }
        format.json { render json: @open_defect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /open_defects/1
  # PUT /open_defects/1.json
  def update
    @open_defect = OpenDefect.find(params[:id])

    respond_to do |format|
      if @open_defect.update_attributes(params[:open_defect])
        format.html { redirect_to @open_defect, notice: 'Open defect was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @open_defect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /open_defects/1
  # DELETE /open_defects/1.json
  def destroy
    @open_defect = OpenDefect.find(params[:id])
    @open_defect.destroy

    respond_to do |format|
      format.html { redirect_to open_defects_url }
      format.json { head :no_content }
    end
  end
end
