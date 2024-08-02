# Users Service Api

This API provides endpoints for creeating and viewing users. It also provides authentication for users to login with github
This API was built to service the codesnacks application. This can be found [here](https://github.com/CodingOnTheJohn/consultancyFE) 

#### [Deployed App](https://consultancy-fe-7544dba9595c.herokuapp.com/)

## Documentation

-  [docs](https://bump.sh/codesnacks/hub/codesnacks/doc/users-api)
-  [Frontend](https://github.com/CodingOnTheJohn/consultancyFE)
-  [Lessons API](https://github.com/CodingOnTheJohn/codinglessonsapi)

## Endpoints

| Method | Endpoint         | Description                    | Parameters                                  | Response                |
|--------|-----------------|--------------------------------|----------------------------------------------|------------------------|
| POST   | /users           | Create a new user             | Request Body (`User`)                        | `UserResponse` (201)    |
| GET    | /users/{id}      | Show a user's details         | Path Parameter (`id`)                        | `UserResponse` (200)    |
| GET    | /login           | Login a user                  | Query Parameters (`user[email]`, `user[password]`) | `UserResponse` (200)    |


## Setup

* Ruby version: 3.2.2

* Rails version: 7.1.3.4

- `bundle install`
- `rails db:setup`
- `rails db:migrate`

How to run the test suite

- `bundle exec rspec`

## Team Members

### Noah Durbin
  - [Github](https://github.com/noahdurbin)
  - [Linkedin](https://www.linkedin.com/in/noahdurbin/)

### Austin Carr-Jones
  - [Github](https://github.com/austincarrjones)
  - [Linkedin](https://www.linkedin.com/in/austin-carr-jones/)

### Dana Howell
  - [Github](https://github.com/DHowell1150)
  - [Linkedin](https://www.linkedin.com/in/dana-l-howell/)

### Garrett Bowman
  - [Github](https://github.com/GBowman1)
  - [Linkedin](https://www.linkedin.com/in/gbowman3/)

## Contributing

Since this is a service serving a larger application, this project is not currently accepting external contributions.
