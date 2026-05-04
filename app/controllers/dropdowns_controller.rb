class DropdownsController < ApplicationController
  def countries
    countries = Employee.distinct.pluck(:country).compact.sort
    render json: countries
  end

  def job_titles
    job_titles = Employee.distinct.pluck(:job_title).compact.sort
    render json: job_titles
  end
end
