class ProjectsController < ApplicationController
	include SprintsHelper
  include OpenDefectsHelper

  # GET /projects
  # GET /projects.json
  def index

    if params[:team_id]
      @team = Team.find(params[:team_id])
      @projects = Project.where(:team_id => @team.id)
    else
      @projects = Project.all
    end



    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @team = Team.find(@project.team_id)
    @all_open_defects = OpenDefect.where(:project_id => @project.id)
    @current_open_defects = OpenDefect.where(:project_id => @project.id).order("week_ending DESC").limit(1).first  #is this correct?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @teams = Team.where(:is_archived => false).order("name")

    if params[:team_id]
      @team = Team.find(params[:team_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    @teams = Team.where(:is_archived => false)
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])


    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    @teams = Team.where(:is_archived => false)

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
