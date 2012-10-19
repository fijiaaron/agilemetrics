class Project < ActiveRecord::Base

	validates :name, :presence => true
	validates :tfs_path, :presence => true
	validates :team_id, :presence => true

	belongs_to :team
	has_many :open_defects

end
