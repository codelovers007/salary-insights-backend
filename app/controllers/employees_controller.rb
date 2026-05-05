class EmployeesController < ApplicationController
  before_action :set_employee, only: [ :show, :update, :destroy ]

  # GET /employees
  def index
    employees = Employee.order(created_at: :desc)
    employees = apply_filters(employees)
    employees = apply_pagination(employees)

    render json: employees.select(*response_fields)
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
      render json: @employee, status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /employees/:id
  def destroy
    if @employee.destroy
      head :no_content
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])
    return if @employee

    render json: { error: "Employee not found" }, status: :not_found
  end

  def apply_filters(scope)
    scope = scope.by_country(params[:country]) if params[:country].present?
    scope = scope.by_job_title(params[:job_title]) if params[:job_title].present?
    scope
  end

  def apply_pagination(scope)
    limit  = params[:limit]&.to_i || Employee.page_limits
    offset = params[:offset]&.to_i || 0

    scope.limit(limit).offset(offset)
  end

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :job_title, :country,
      :salary, :department, :date_of_joining
    )
  end

  def response_fields
    [ :id, :first_name, :last_name, :job_title, :country, :salary ]
  end
end
