require 'rails_helper'

RSpec.describe "Insights API", type: :request do
  describe "GET /insights/country" do
    before do
      create(:employee, country: "India", salary: 50000)
      create(:employee, country: "India", salary: 70000)
    end

    it "returns min, max, avg" do
      get "/insights/country", params: { country: "India" }

      data = JSON.parse(response.body)

      expect(data["min"].to_f).to eq(50000)
      expect(data["max"].to_f).to eq(70000)
      expect(data["avg"]).to eq(60000.0)
    end
  end

  describe "GET /insights/job" do
    before do
      create(:employee, country: "India", job_title: "Engineer", salary: 50000)
      create(:employee, country: "India", job_title: "Engineer", salary: 70000)
    end

    it "returns avg salary" do
      get "/insights/job", params: {
        country: "India",
        job_title: "Engineer"
      }

      data = JSON.parse(response.body)
      expect(data["avg"].to_f).to eq(60000.0)
    end
  end

  describe "GET /insights/top_paid" do
    before do
      create(:employee, salary: 50000)
      create(:employee, salary: 100000)
    end

    it "returns highest paid employees" do
      get "/insights/top_paid"

      data = JSON.parse(response.body)

      expect(data.first["salary"].to_f).to eq(100000)
    end
  end
end
