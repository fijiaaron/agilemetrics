module OpenDefectsHelper

  @@OPEN_DEFECTS_REPORT_NUMBER_OF_WEEKS = 52
  @@DEFAULT_SPRINT_WEEKS = 2



  # return all open defects reports for a project up to number (default is 52 weeks)
  def open_defects_for_project(project, number=@@OPEN_DEFECTS_REPORT_NUMBER_OF_WEEKS)
    OpenDefect.where(:project_id => project.id).order("week_ending DESC").limit(number)
  end



  # return only the latest open defects report for a project
  def current_open_defects_for_project(project)
    return OpenDefect.where(:project_id => project.id).order("week_ending DESC").limit(1)
  end



  # return open defects report in a format that the google visualization api can use
  def get_open_defects_data_table(open_defects, sprint_weeks=@@DEFAULT_SPRINT_WEEKS)
    result = []

    headers = ['Week', 'Critical', 'High', 'Medium', 'Low'];
    result.push headers

    @open_defects.reverse_each do |weekly_report|
      data = [
        "Week ending " + weekly_report.week_ending.strftime("%Y.%m.%d"),
        weekly_report.critical,
        weekly_report.high,
        weekly_report.medium,
        weekly_report.low,
      ]

      result.push data
    end

    return result
  end



  # return open defects report in a format that the google visualization api can use
  # filter to show only the report for the last week of the sprint (approximately)
  # change the date displayed from Saturday to Friday
  def get_open_defects_for_sprint_data_table(open_defects, sprint_weeks=@@DEFAULT_SPRINT_WEEKS)
    result = []

    headers = ['Week', 'Critical', 'High', 'Medium', 'Low'];
    result.push headers

    week_number = 0
    @open_defects.reverse_each do |weekly_report|
      data = [
        # change the day displayed from Saturday to Friday
        (weekly_report.week_ending - 24.hours).strftime("%Y.%m.%d"),
        weekly_report.critical,
        weekly_report.high,
        weekly_report.medium,
        weekly_report.low,
      ]

      # only display open defects for the week at the end of each sprint
      # this isn't guaranteed to be accurate because sprint weeks might be off
      if week_number == sprint_weeks
        week_number = 0
        result.push data
      end
      week_number +=1
    end

    return result
  end

end
