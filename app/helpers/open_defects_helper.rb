module OpenDefectsHelper

  def open_defects_for_project(project)
    OpenDefect.find(:project_id => project.id)
  end

  def current_open_defects_for_project(project)
    return OpenDefect.where(:project_id => project.id).order("week_ending DESC").limit(1)
  end
end
