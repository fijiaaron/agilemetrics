class TeamsController < ApplicationController
  include SprintsHelper
  include OpenDefectsHelper



  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.order("UPPER(name) asc")
    @active_teams = @teams.where(:is_archived => false)
    @archived_teams = @teams.where(:is_archived => true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end



  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    @summary_sprint = last_complete_sprint(@team.sprints)
    @first_sprint = @team.sprints.find(:first)
    @last_sprint = @team.sprints.find(:last)
    @linear_regression = get_linear_regression_actual_velocity(@team.sprints, @last_sprint)
    @averages_set = last_n_sprints_inclusive(@team.sprints, @summary_sprint, 6)

    #NOTE: only allowed 1 project per team (for now)
    if @team.projects.size > 0
      @project = @team.projects[0]
      @open_defects = open_defects_for_project(@project, @@OPEN_DEFECTS_REPORT_NUMBER_OF_WEEKS)
      @open_defects_data_table = get_open_defects_data_table(@open_defects, @team.sprint_weeks)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end



  # GET /averages
  # GET /averages.json
  def averages
    @teams = Team.order("UPPER(name) asc")
  @active_teams = @teams.where(:is_archived => false)
  @archived_teams = @teams.where(:is_archived => true)

    respond_to do |format|
      format.html # averages.html.erb
      format.json { render json: @teams }
    end
  end



  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new
  @team.owners = current_user.login if current_user != nil

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end



  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end



  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end



  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end
end
