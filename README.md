# Restaurant API

This API provides restaurant search functionality and allows users to flag restaurants as favorites. It uses the Google Places API as the data source for restaurant information.

## Features

- Search for restaurants based on a query
- View basic information about each restaurant, including name, location, and photo URL
- Flag restaurants as favorites and view their favorite status
- User authentication for the favorite functionality

## Requirements

- Ruby 3.2.2
- Rails 7.0.6
- PostgreSQL
- Google Places API key

## Getting Started

1. Clone the repository:

```shell
git clone https://github.com/your_username/restaurant-api.git
```

2. Install the dependencies:

```shell
cd restaurant-api
bundle install
```

3. Set up the database:

```shell
rails db:create
rails db:migrate
```

4. Set up the environment variables:

Create a `.env` file in the root directory and add the following variables:

```plaintext
GOOGLE_PLACES_API_KEY=your_google_places_api_key
```

5. Start the server:

```shell
rails server
```

The API will be available at `http://localhost:3000`.

## API Endpoints

### POST /api/v1/search

Search for restaurants based on a query.

Parameters:

- `query` (required): The search query for restaurants.

Example Request:

```shell
curl -X POST http://localhost:3000/api/v1/search -H "Authorization: Bearer your_jwt_token" -d 'query=chinese restaurant'
```

Example Response:

```json
[
  {
    "place_id": "ChIJEZRiXG39YjkRuwqVTDynJ54",
    "name": "Vishnu Veg And Chinese Restaurant And Tifine Center",
    "location": "Chandra Nagar, A B Road, Sudha Com, Indore, Madhya Pradesh 452007, India",
    "photo_url": "https://example.com/photo123.jpg",
    "favorite": true
  },
  {
    "place_id": "ChIJEZRiXG39YjkRuwqVTDynJ55",
    "name": "ABC Chinese Restaurant",
    "location": "123 Main St, Anytown, USA",
    "photo_url": "https://example.com/photo456.jpg",
    "favorite": false
  }
]
```

### POST /api/v1/restaurants/:id/favorite

Toggle the favorite status of a restaurant.

Parameters:

- `id` (required): The place ID of the restaurant.

Example Request:

```shell
curl -X POST http://localhost:3000/api/v1/restaurants/ChIJEZRiXG39YjkRuwqVTDynJ54/favorite -H "Authorization: Bearer your_jwt_token"
```

Example Response:

```json
{
  "message": "Restaurant added to favorites",
  "favorite": true
}
```

## Authentication

To access protected API endpoints, include the JWT token in the `Authorization` header of your request. The JWT token can be obtained by logging in with valid credentials.

### POST /users/sign_in

Authenticate a user and obtain the JWT token.

Parameters:

- `user[email]` (required): User email.
- `user[password]` (required): User password.

Example Request:

```shell
curl -X POST http://localhost:3000/users/sign_in -d 'user[email]=user@example.com' -d 'user[password]=password'
```

Example Response:

```json
{
  "message": "User logged in successfully",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "created_at": "2023-01-01T12:00:00Z",
    "updated_at": "2023-01-01T12:00:00Z"
  },
  "token": "your_jwt_token"
}
```

## Testing

Run the test suite with RSpec:

```shell
bundle exec rspec
```

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your improvements.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).
```

Feel free to customize and modify the README to match your project's specific details and requirements.