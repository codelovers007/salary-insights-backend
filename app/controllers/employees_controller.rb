class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  # GET /employees
  def index
    employees = Employee.all

    # Filtering
    employees = employees.by_country(params[:country]) if params[:country].present?
    employees = employees.by_job_title(params[:job_title]) if params[:job_title].present?

    # Pagination
    limit = params[:limit]&.to_i || Employee.page_limits
    offset = params[:offset]&.to_i || 0

    employees = employees.limit(limit).offset(offset)

    render json: employees
  end

  # GET /employees/:id
  def show
    render json: @employee
  end

  # POST /employees
  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /employees/:id
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /employees/:id
  def destroy
    if @employee.destroy
      render json: { success: 'Deleted Successfully' }, status: 200
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])
    render json: { error: "Employee not found" }, status: :not_found unless @employee
  end

  def employee_params
    params.require(:employee).permit( :full_name, :job_title, :country,
                                    :salary, :department, :date_of_joining
    )
  end

  def response_fields
    [:id, :full_name, :job_title, :country, :salary, :department, :date_of_joining]
  end
end
