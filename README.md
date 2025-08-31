# jaspr\_auth\_test

**Example showing how to implement authentication with Jaspr and Serverpod – a simple To-Do application.**

---

## 📝 Overview

This repository demonstrates how to integrate authentication into a **Jaspr** app using **Serverpod**, wrapped in a simple "To-Do" application. Ideal for developers exploring full-stack Dart frameworks and secure user management.

---

## Project Structure

```
jaspr_auth_test/
├── jaspr_auth_test_client        # The client-side Jaspr application
├── jaspr_auth_test_server        # The Serverpod backend providing auth and data APIs
├── website_river_auth            # Web interface with Riverpod based auth
├── .github/workflows             # CI/CD workflows
├── .vscode                       # Editor configurations
└── .gitignore
```

---

## Features

* **User authentication** via Serverpod (registration, login, user sessions)
* **Secure API endpoints** for adding and managing To-Do items
* **Frontend integration**: Jaspr app consumes authenticated endpoints in a reactive UI
* **Riverpod integration** for state management

---

## Usage

### Prerequisites

* Dart SDK
* PostgreSQL (Serverpod default)
* Serverpod CLI installed

### Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/charafau/jaspr_auth_test
   cd jaspr_auth_test
   ```

2. **Set up the backend**

   ```bash
   cd jaspr_auth_test_server
   ```

   * Configure database connection (e.g., in `config.yaml`)
   * Run migrations:

     ```bash
     serverpod generate
     serverpod migrate
     ```
   * Start the server:

     ```bash
     dart run bin/main.dart --apply-migrations
     ```

3. **Run the frontend**

   ```bash
   cd ../website_river_auth
   jaspr serve --port 8000
   ```

