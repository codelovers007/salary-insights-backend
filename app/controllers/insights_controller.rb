class InsightsController < ApplicationController
  before_action :check_country_params, only: [ :country, :job ]

  # GET /insights/country?country=India
  def country
    analytics = Employee.by_country(params[:country])
                        .select("MIN(salary) as min_sal,
																MAX(salary) as max_sal,
																AVG(salary) as avg_sal").first

    render json: { min: analytics.min_sal,
                   max: analytics.max_sal,
                  avg: analytics.avg_sal
                }
  end

  # GET /insights/job?country=India&job_title=Engineer
  def job
    job_title = params[:job_title]

    return render json: { error: "job_title is required" }, status: :unprocessable_entity  unless job_title

    avg = Employee.by_country(params[:country])
                  .by_job_title(job_title)
                  .average(:salary).to_f

    render json: { avg: avg }
  end

  # GET /insights/top_paid
  def top_paid
    limit = params[:limit]&.to_i || 10

    data = Employee.order(salary: :desc).limit(limit)
                  .select(:id, :first_name, :last_name, :salary, :country, :job_title)

    render json: data
  end

  private

  def check_country_params
    render json: { error: "country is required" }, status: :unprocessable_entity unless params[:country]
  end
end
