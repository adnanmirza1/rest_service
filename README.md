# My Rails Application

This is a Ruby on Rails application that implements user authentication, background jobs, and RESTful API endpoints. It uses JWT for authentication and Sidekiq for background processing.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Running the Application](#running-the-application)
- [Testing the Application](#testing-the-application)
- [API Endpoints](#api-endpoints)
- [Background Jobs](#background-jobs)
- [License](#license)

## Prerequisites

Before you begin, ensure you have met the following requirements:
- Ruby 3.3.0
- Rails 7.0.8.4
- PostgreSQL (or your preferred database)
- Redis (for Sidekiq)
- Docker (optional, for containerization)

## Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/adnanmirza1/rest_service.git
   cd rest_service
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Configure the database**:
   - Update `config/database.yml` with your database credentials.
   - Create the database:
     ```bash
     rails db:create
     rails db:migrate
     ```

4. **Set up Redis** (if not using Docker):
   - Install Redis on your machine or use a service like Redis Cloud.
   - Start the Redis server:
     ```bash
     redis-server
     ```

5. **(Optional) Set up Docker**:
   - Build the Docker image:
     ```bash
     docker build -t my_app .
     ```
   - Run the Docker container:
     ```bash
     docker run -p 3000:3000 my_app
     ```

## Running the Application

To start the Rails server, run:
```bash
rails server
```

The application will be available at `http://localhost:3000`.

## Testing the Application

### API Testing

You can test the API endpoints using tools like Postman or curl. Here are some example requests:

1. **Sign Up**:
   ```bash
   curl -X POST http://localhost:3000/signup -H "Content-Type: application/json" -d '{
     "user": {
       "name": "John Doe",
       "email": "john@example.com",
       "password": "password123"
     }
   }'
   ```

2. **Log In**:
   ```bash
   curl -X POST http://localhost:3000/login -H "Content-Type: application/json" -d '{
     "email": "john@example.com",
     "password": "password123"
   }'
   ```

3. **Get Users** (requires authentication):
   ```bash
   curl -X GET http://localhost:3000/users -H "Authorization: Bearer YOUR_JWT_TOKEN"
   ```

4. **Get Items**:
   ```bash
   curl -X GET http://localhost:3000/items
   ```

5. **Create Item**:
   ```bash
   curl -X POST http://localhost:3000/items -H "Content-Type: application/json" -d '{
     "item": {
       "name": "Sample Item",
       "description": "This is a sample item."
     }
   }'
   ```

6. **Update Item** (replace `ITEM_ID` with the actual item ID):
   ```bash
   curl -X PUT http://localhost:3000/items/ITEM_ID -H "Content-Type: application/json" -d '{
     "item": {
       "name": "Updated Item",
       "description": "This is an updated item."
     }
   }'
   ```

7. **Show Item** (replace `ITEM_ID` with the actual item ID):
   ```bash
   curl -X GET http://localhost:3000/items/ITEM_ID
   ```

### Background Job Testing

After signing up, a background job will be triggered to send a welcome email. Ensure that Sidekiq is running in a separate terminal:
```bash
bundle exec sidekiq
```

## API Endpoints

### User Endpoints
- **POST /signup**: Create a new user.
- **POST /login**: Authenticate a user and return a JWT token.
- **GET /users**: Retrieve a list of users (requires JWT token).

### Item Endpoints
- **GET /items**: Retrieve a list of items.
- **POST /items**: Create a new item.
- **PUT /items/:id**: Update an existing item (requires item ID).
- **GET /items/:id**: Retrieve a specific item by ID.

## Background Jobs

The application uses Sidekiq for background processing. The `UserNotificationJob` is triggered after a user signs up to send a welcome email.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
