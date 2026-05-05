class DropdownsController < ApplicationController
  def countries
    render json: fetch_distinct_records(:country)
  end

  def job_titles
    render json: fetch_distinct_records(:job_title)
  end

  private

  def fetch_distinct_records(column)
    Employee
      .where.not(column => nil)
      .distinct
      .order(column)
      .pluck(column)
  end
end
