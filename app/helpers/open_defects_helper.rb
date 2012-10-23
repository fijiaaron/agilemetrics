module OpenDefectsHelper


  @@OPEN_DEFECTS_REPORT_NUMBER_OF_WEEKS = 52

  # return all open defects reports for a project up to number (default is 52 weeks)
  def open_defects_for_project(project, number=52)
    OpenDefect.where(:project_id => project.id).order("week_ending DESC").limit(number)
  end


  # return only the latest open defects report for a project
  def current_open_defects_for_project(project)
    return OpenDefect.where(:project_id => project.id).order("week_ending DESC").limit(1)
  end


  @@DEFAULT_SPRINT_WEEKS = 2

  def get_open_defects_data_table(open_defects, sprint_weeks=@@DEFAULT_SPRINT_WEEKS)
    result = []

    headers = ['Week', 'Critical', 'High', 'Medium', 'Low'];
    result.push headers

    week_number = 0
    @open_defects.reverse_each do |weekly_report|
      data = [
        (weekly_report.week_ending - 24.hours).strftime("%Y.%m.%d"),
        weekly_report.critical,
        weekly_report.high,
        weekly_report.medium,
        weekly_report.low,
      ]

      #only display open defects for the end of each sprint
      if week_number == sprint_weeks
        week_number = 0
        result.push data
      end
      week_number +=1
    end

    result
  end

end
