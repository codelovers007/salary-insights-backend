class Employee < ApplicationRecord
	scope :by_country, ->(country) { where(country: country) }
	scope :by_job_title, ->(title) { where(job_title: title) }

	def self.page_limits
		50
	end
end
