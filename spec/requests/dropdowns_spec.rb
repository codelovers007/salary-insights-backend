require 'rails_helper'

RSpec.describe "Dropdowns API", type: :request do
  before do
    create(:employee, country: "India", job_title: "Engineer")
    create(:employee, country: "USA", job_title: "Manager")
  end

  describe "GET /dropdowns/countries" do
    it "returns unique countries" do
      get "/dropdowns/countries"

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      expect(data).to match_array(["India", "USA"])
    end
  end

  describe "GET /dropdowns/job_titles" do
    it "returns unique job titles" do
      get "/dropdowns/job_titles"

      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)

      expect(data).to include("Engineer", "Manager")
    end
  end
end