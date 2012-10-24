module ProjectsHelper

  # determines if the team for a project is the one selected (for the team dropdown)
  def selected?(team)
    if not team.nil?
	   return team
    end
  end

end
