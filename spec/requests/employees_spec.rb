require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  describe "GET /employees" do
    before do
      create(:employee, country: "India", job_title: "Engineer")
      create(:employee, country: "USA", job_title: "Manager")
    end

    it "returns all employees" do
      get "/employees"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to be >= 2
    end

    it "filters by country" do
      get "/employees", params: { country: "India" }

      data = JSON.parse(response.body)
      expect(data.all? { |e| e["country"] == "India" }).to be true
    end
  end

  describe "GET /employees/:id" do
    let!(:employee) { create(:employee, first_name: "Niraj") }

    it "returns the employee" do
      get "/employees/#{employee.id}"

      expect(response).to have_http_status(:ok)

      data = JSON.parse(response.body)
      expect(data["id"]).to eq(employee.id)
      expect(data["first_name"]).to eq("Niraj")
    end

    it "returns 404 if employee not found" do
      get "/employees/999999"

      expect(response).to have_http_status(:not_found)

      data = JSON.parse(response.body)
      expect(data["error"]).to eq("Employee not found")
    end
  end

  describe "POST /employees" do
    it "creates employee" do
      post "/employees", params: {
        employee: {
          first_name: "Niraj",
          last_name: "Dharwal",
          job_title: "Engineer",
          country: "India",
          salary: 60000
        }
      }

      expect(response).to have_http_status(:created)
      expect(Employee.count).to eq(1)
    end

    it "fails with invalid data" do
      post "/employees", params: { employee: { first_name: "" } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT /employees/:id" do
    let!(:employee) { create(:employee) }

    it "updates employee" do
      put "/employees/#{employee.id}", params: {
        employee: { first_name: "Updated" }
      }

      expect(response).to have_http_status(:ok)
      expect(employee.reload.first_name).to eq("Updated")
    end
  end

  describe "DELETE /employees/:id" do
    let!(:employee) { create(:employee) }

    it "deletes employee" do
      delete "/employees/#{employee.id}"

      expect(response).to have_http_status(:no_content)
      expect(Employee.exists?(employee.id)).to be false
    end
  end
end
