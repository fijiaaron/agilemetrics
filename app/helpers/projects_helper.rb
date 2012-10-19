module ProjectsHelper


  def selected?(team)
    if not team.nil?
	  return team
    end
  end

end
