# Backend Development Documentation

## Table of Contents

- [Adding a new service](#adding-a-new-service)
    - [What is a service?](#what-is-a-service)
    - [Adding a new module](#adding-a-new-module)
    - [Adding a new controller (route)](#adding-a-new-controller-route)
    - [Adding a new service (business logic)](#adding-a-new-service-business-logic)
    - [With 2oauth authentication](#with-2oauth-authentication)
    - [Without 2oauth authentication](#without-2oauth-authentication)
- [Testing](#testing)
    - [Writing Tests](#writing-tests)
    - [Running Tests](#running-tests)
- [Database Management](#database-management)
    - [Database Setup](#database-setup)
    - [Database Schema](#database-schema)
- [API Documentation](#api-documentation)
    - [API Endpoints](#api-endpoints)
    - [Authentication](#authentication)
- [Troubleshooting and Support](#troubleshooting-and-support)
- [Additional Resources](#additional-resources)

## Adding a new service

### What is a service?

- A service is a third party service that we want to integrate with.
- A service can be a social media platform, a cloud storage platform, a payment platform, etc.
- A service contains the actions and reactions that the user can use in their rules.
- A service can be added to the backend by following the steps below.

### Adding a new module

- In the `api/src/` folder, create a new folder with the name of the service. ex: `api/src/MyService`.
- Use NestJS CLI to generate a new module in the new folder. ex:
```sh
nest g module my-service
```
- Add the new module to the `api/src/app.module.ts` file.

### Adding a new controller (route)

- In the `api/src/` folder, use NestJS CLI to generate a new controller. ex:
```sh
nest g controller my-service
```
- Add the new controller to the `api/src/my-service/my-service.module.ts` file.

### Adding a new service (business logic)

- In the `api/src/` folder, use NestJS CLI to generate a new service. ex:
```sh
nest g service my-service
```
- Add the new service to the `api/src/my-service/my-service.module.ts` file.

### With 2oauth authentication

- Make a controller that gets the user's access token from the front end.
- Now you can interact with the 2oauth API of the service using the access token.

### Without 2oauth authentication

- Get the API key from the service's website.
- Use the API key to interact with the service's API.

## Testing

### Writing Tests

- Two ways to write tests:
    - Jest: Unit tests.
    - Scripts: Unit tests and integration tests.

Chose the one that suits your needs.

### Running Tests

- If you chose Jest, run the tests using the following command:
```sh
npm run test
```
- If you chose Scripts, run the tests using the following command:
```sh
./<your-script>.sh
```

## Database Management

### Database Setup

- Refer to the [introduction documentation](./Introduction.md) for the database setup.

### Database Schema

- We use DTOs to interact with the database.
    - You need to create a DTO for each interaction used in the database. (Create, Read, Update, Delete)

## API Documentation

### API Endpoints

- Once the backend is running, the API documentation can be accessed at `http://localhost:8000/api`.
- A release version of the API documentation can be found [here](http://patatoserv.ddns.net:8085/api).

### Authentication

- Most routes require authentication.
- Use the `/auth/login` or `/auth/register` route to get an access token.
- Use the access token in the `Authorization` header of your requests.

## Troubleshooting and Support

- If you have any questions, please contact the project maintainer.

## Additional Resources

- [NestJS](https://nestjs.com/)
- [MongoDB](https://www.mongodb.com/)
- [NodeJS](https://nodejs.org/en/)
- [TypeScript](https://www.typescriptlang.org/)
- [Git](https://git-scm.com/)
- [Introduction](../Introduction.md)
- [Technologies](../Technologies.md)
- [Frontend Development Documentation](./Front-end.md)

---

*This document is subject to change and will be updated as needed.*
