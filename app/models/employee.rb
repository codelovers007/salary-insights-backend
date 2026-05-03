class Employee < ApplicationRecord
	scope :by_country, ->(country) { where(country: country) }
	scope :by_job_title, ->(title) { where(job_title: title) }

	before_validation :set_full_name

	def self.page_limits
		50
	end

	private

	def set_full_name
		if first_name.present? && last_name.present?
			self.full_name = "#{first_name} #{last_name}"
		end
	end
end
