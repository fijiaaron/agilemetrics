module OpenDefectsHelper

  # return all open defects reports for a project up to number (default is 52 weeks)
  def open_defects_for_project(project, number=52)
    OpenDefect.where(:project_id => project.id).order("week_ending DESC").limit(number)
  end


  # return only the latest open defects report for a project
  def current_open_defects_for_project(project)
    return OpenDefect.where(:project_id => project.id).order("week_ending DESC").limit(1)
  end
end
