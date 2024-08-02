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
| POST   | /users           | Create a new user             | Request Body (`User`)                        | `UserResponse` (201)   |
| GET    | /users/{id}      | Show a user's details         | Path Parameter (`id`)                        | `UserResponse` (200)   |
| GET    | /login           | Login a user                  | Query Parameters (`user[email]`, `user[password]`) | `UserResponse` (200)    |
| GET    | /login           | Login a user                  | Query Parameters (`user[email]`, `user[password]`) | `UserResponse` (200)    |
| POST   | /github_users    | Github login/create account   |                                              |  `UserResponse` (201)  |

#### post `/users`
body 
```
{
  users{
    username: 'example',
    email: 'example@example.com',
    phone_number: '123465789',
    text_preference: true,
    password: 'password',
    password_confirmation: 'password'
  }
}
```
note: password and password confirmation must match

200 response

```
{
  "data": {
    "id": "example",
    "type": "example",
    "attributes": {
      "email": "example@example.com",
      "username": "example",
      "id": 42
    }
  }
}
```

422 response
```
{
  "errors": [
    {
      "status": "string",
      "title": "string"
    }
  ]
}
```

#### get user `/users/{id}`

200 response
```
{
  "data": {
    "id": "example",
    "type": "example",
    "attributes": {
      "email": "example@example.com",
      "username": "example",
      "id": 42
    }
  }
}
```

404 response
```
{
  "errors": [
    {
      "status": "string",
      "title": "string"
    }
  ]
}
```

#### User Login, get `/login`
request must include query paramaters of email and password

if user is found and username and password match a user will be returned
```
{
  "data": {
    "id": "example",
    "type": "example",
    "attributes": {
      "email": "example@example.com",
      "username": "example",
      "id": 42
    }
  }
}
```

if no matching user is found(404) or password is incorrect(401) you will recieve an error
```
{
  "errors": [
    {
      "status": "string",
      "title": "string"
    }
  ]
}
```

#### Login/create Github User, post `/github_users`
this will redirect you to github where you will be asked to login with your github account and authorize access to your account

if successful
```
{
  "data": {
    "id": "example",
    "type": "example",
    "attributes": {
      "email": "example@example.com",
      "username": "example",
      "id": 42
    }
  }
}
```

if not you will recieve an error
```
{
  "errors": [
    {
      "status": "string",
      "title": "string"
    }
  ]
}
```


## Database Diagram

![diagram](https://github.com/CodingOnTheJohn/codingonthejohnBE/blob/main/Untitled%20from%20dbdiagram.png)

## Setup

* Ruby version: 3.2.2

* Rails version: 7.1.3.4

- `bundle install`
- `rails db:setup`
- `rails db:migrate`
- run `redis server`
- run `rails server`

to run the test suite

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

