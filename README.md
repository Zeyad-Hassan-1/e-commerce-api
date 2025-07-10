# 🛒 Shopping Cart API

A professional Ruby on Rails API for managing an e-commerce system with authentication, cart management, orders, reviews, and API documentation via Swagger.

## 📑 Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [API Documentation](#api-documentation)
- [Authentication](#authentication)
- [Error Handling](#error-handling)
- [Screenshots](#screenshots)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)
- [Support](#support)

---

## ✨ Features
- 🔐 JWT authentication
- 👤 User registration & login
- 👨‍💼 role-based access control (admin/user)
- 📧 confirmation email via SendGrid
- 😧 forgot and reset password functionality
- 📦 Product & category management
- ❤️ Favorites system
- 🛍️ Cart & item operations with color/size selection
- 🧾 Orders & checkout
- 💬 Reviews
- 📘 Swagger-powered API docs
- 📄 Pagination with metadata

---

## 🧰 Tech Stack
- Ruby 3.2+
- Rails 7+
- PostgreSQL
- RSwag (Swagger Docs)
- custom JWT auth
- RSpec, RuboCop, Brakeman
- sendgrid for email notifications

---

## 📦 Prerequisites
- Ruby (3.2+)
- PostgreSQL
- Node.js & Yarn
- `mise` version manager (recommended)

---

## ⚙️ Installation

```bash
git clone https://github.com/Zeyad-Hassan-1/e-commerce-api.git
cd e-commerce-api
bundle install
```

---

## 🧪 Configuration

1. Create `.env` file from the example:
```bash
cp .env.example .env
```

2. Fill in required environment variables:
```env
SENDGRID_USERNAME=apikey
SENDGRID_PASSWORD=your_sendgrid_api_key
DATABASE_URL=your_database_url
JWT_SECRET=your_secret_key # to create secret key, run `rails secret`
RAILS_MASTER_KEY=your_master_key #found in config/master.key
```

---

## 🗃️ Database Setup

```bash
rails db:create
rails db:migrate
rails db:seed # optional
```

---

## 🖥️ Running the Application

```bash
rails server
```

Visit: [http://localhost:3000](http://localhost:3000)

---

## 📚 API Documentation

Available at: [http://localhost:3000/api-docs](http://localhost:3000/api-docs)

---

## 🔑 Authentication

Uses JWT Bearer Token system.

- Register or login to get a token
- Include it in requests:
```http
Authorization: Bearer your_token_here
```

---

## ⚠️ Error Handling

Standard HTTP status codes:
- `2xx` → Success
- `4xx` → Client error (e.g., Unauthorized, Not Found)
- `5xx` → Server error

All error responses contain descriptive JSON messages.

---

## 🚀 Deployment

Use any cloud provider or self-hosted solution

Or push to platforms like:
- Render
- Railway
- Fly.io
- Heroku (with container support)

Make sure:
- `DATABASE_URL` is set
- `RAILS_MASTER_KEY` is passed as ENV variable

---

## 🤝 Contributing

1. Fork the repo
2. Create a new branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "Add some feature"`
4. Push: `git push origin feature/your-feature`
5. Submit a Pull Request

---

## 👨‍💻 Support

Created with ❤️ by [Zeyad Hassan](https://github.com/Zeyad-Hassan-1)

For questions or help, open an issue on GitHub.
