
# Project Title

A brief description of what this project does and who it's for

# 💼 Salary Insights Platform

A full-stack salary management and insights tool built for HR managers to manage employees and analyze salary data across countries and job roles.

---

## 🚀 Live Demo

- 🔗 Backend API: https://salary-insights-backend.onrender.com  
- 🔗 Frontend: https://salary-insights-frontend.onrender.com

---

## 🧠 Features

### 👨‍💼 Employee Management
- Add, view, update, and delete employees
- Pagination and filtering (by country & job title)
- Employee detail view

### 📊 Salary Insights
- Min, Max, Avg salary by country
- Avg salary by job title within a country
- Top 10 highest paid employees

### 🎯 UI/UX
- Dashboard with insights
- Dropdown filters
- Clean table with actions (View / Edit / Delete)

---

## 🏗️ Tech Stack

### Backend
- Ruby on Rails (API mode)
- SQLite (Dev) / PostgreSQL (Production)
- RSpec (Testing)
- Brakeman (Security)
- RuboCop (Linting)

### Frontend
- React (Vite)
- Axios
- React Router

### Deployment
- Backend: Render
- Frontend: Render

---

## ⚙️ Setup Instructions

### 🔹 Backend Setup

```bash
git clone <repo>
cd salary-insights-backend

bundle install
rails db:create db:migrate db:seed

rails server
