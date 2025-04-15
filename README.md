# 💸 Sarf – Personal Finance & Budget Management App

**Sarf** (صرف) is a simple and intuitive personal finance and budgeting app designed to help individuals — especially young Saudis — track their expenses, manage their income, and gain better control of their financial habits.

---

## 🎯 Purpose

Many people struggle with knowing where their salary goes. Sarf addresses this problem by making expense tracking easy and insightful, with helpful notifications that guide users toward better saving and spending behaviors.

> 🧠 *Example:* "Your spending on restaurants this week increased by 30% compared to your average."  
> 👉 *Suggested:* "Try limiting dining out to 2 times next week to save 300 SAR."

---

## 🛠️ Tech Stack

### 💻 Backend
- **FastAPI** — Modern, fast (high-performance) Python web framework for building APIs.
- **PostgreSQL** — Relational database for storing user data, transactions, budgets.
- **SQLAlchemy** — ORM for database interactions.
- **Alembic** — Database migrations.
- **JWT Auth** — For secure user authentication.

### 📱 Frontend (Planned)
- **Flutter** — Cross-platform mobile app for Android and iOS.
- **Bloc Pattern** — State management for clean architecture.

### ☁️ Deployment (Planned)
- Dockerized backend for containerized deployment.
- CI/CD integration (Git/GitHub).

---

## 📦 Core Features (MVP)

- 🧾 Record daily expenses manually or through OCR (planned)
- 📊 Visualize spending by category, time period
- 🔔 Smart notifications for overspending / saving goals
- 📁 Monthly budget planning
- 💡 AI-powered suggestions to reduce wasteful spending (future feature)
- 🔒 Secure login with token-based authentication
- 🇸🇦 Arabic-first experience, fully bilingual interface (Arabic & English)

---

## 📂 Project Structure (Backend)