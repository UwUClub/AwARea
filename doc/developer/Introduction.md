# AwArea - Developer Documentation

## Overview

- The AwArea project is a web and mobile application that allows users to set up and manage their own action and reaction rules.
- It's heavily inspired by IFTTT and Zapier.

### Architecture Overview

- Follow the [NestJS architecture](https://docs.nestjs.com)
    - Use the [NestJS CLI](https://docs.nestjs.com/cli/overview) to generate modules, controllers, services, etc.
    - Use the [NestJS style guide](https://docs.nestjs.com/standards/style-guide)
- Follow the [Flutter architecture](https://docs.flutter.dev/ui)

### Technology Stack

- Check out the [Technologies](Technologies.md) document for more information.

## Environment Setup

### Prerequisites

| Language / Tools | Link | Description |
|:---:|:---:|:---:|
| [![My Skills](https://skillicons.dev/icons?i=docker)](Docker) | [**Docker**](https://www.docker.com/) | Docker is used to containerize the application, the api and the database. |
| [![My Skills](https://skillicons.dev/icons?i=mongodb)](MongoDB) | [**MongoDB**](https://www.mongodb.com/) | MongoDB is used as the database for the application. (not mandatory if using Docker) |
| [![My Skills](https://skillicons.dev/icons?i=nodejs)](NodeJS) | [**NodeJS**](https://nodejs.org/en/) | NodeJS is used to run the application. (not mandatory if using Docker) |
| [![My Skills](https://skillicons.dev/icons?i=typescript)](TypeScript) | [**TypeScript**](https://www.typescriptlang.org/) | TypeScript is used to write the application. |
| [![My Skills](https://skillicons.dev/icons?i=flutter)](Flutter) | [**Flutter**](https://flutter.dev/) | Flutter is used to write the mobile application. |
| [![My Skills](https://skillicons.dev/icons?i=git)](Git) | [**Git**](https://git-scm.com/) | Git is used for version control. |
---

### Installation Steps

1. Clone the repository:
```sh
git clone git@github.com:UwUClub/AwARea.git
```
2. Install dependencies:
    - Check each link from the [Prerequisites](#prerequisites) section.
    - Run `npm install` in the api directory of the project.
3. Set up environment variables:
    - Create a `.env` file in the api directory of the project.
    - Copy the contents of `.env.example` into `.env`.
    - Fill in the values for the environment variables.

### Common Issues and Troubleshooting

- Backend not working: Check if the MongoDB server is running and if the environment variables are set correctly.

## Codebase Structure

### Directory Structure
#### **`.github`** : Contains the github actions.

#### **`api`** : Contains the backend code.
- src : Contains the source code of the backend.
    - Each folder contains a module of the backend except for `_utils` which contains the common utils of the backend.
- test : Contains the tests of the backend.

#### **`flutter_area`** : Contains the mobile and web application code.
- lib : Contains the source code of the mobile and web application.
    - UI : Contains the UI code of the mobile and web application.
    - Core : Contains the Locator and the Manager of the mobile and web application.
    - l10n : Contains the localization of the mobile and web application.
    - Utils : Contains the common utils of the mobile and web application.
- test : Contains the tests of the mobile and web application.

#### **`doc`** : Contains the documentation.
- developer : Contains the developer documentation.
- user : Contains the user documentation.

### Coding Standards
Linter used : [tslint](https://palantir.github.io/tslint/) and [flutter_lints](https://pub.dev/packages/flutter_lints).

Formatter used : [prettier](https://prettier.io/).

Each work repository has its own linter and formatter configuration files.

## Development Workflow

### Branching Strategy

- Main branch: `main` (protected)
- Development branch: `dev` (protected)
- Feature branches: `AW-<issue number>-<feature name>` ex: `AW-1-Login`
- Hotfix branches: `AW-<issue number>-<hotfix name>` ex: `AW-1-LoginFix`
- Release branches: `v<version number>` ex: `v1.0.0`
- Tagging: `v<version number>` ex: `v1.0.0`
- Pull requests: `AW-<issue number>-<feature name>` ex: `AW-1-Login`
- Commit messages: `<Verb> <Description>` ex: `Add Login feature`

### Pull Request Process

- Feature branches are merged into the `dev` branch via pull requests.
- Pull requests are reviewed by at least *one* other team member.
- Pull requests are merged into the `dev` branch after approval.
- Pull requests are merged into the `main` branch after a release.

### Testing Standards

- Unit tests are written for all backend and frontend code.
- Make a script for your tests

## Build and Deployment

### Local Build Instructions

- docker compose up

## API Documentation

### API Endpoints

- Once the backend is running, the API documentation can be accessed at `http://localhost:8000/api`.
- A release version of the API documentation can be found [here](http://patatoserv.ddns.net:8085/api).

### Authentication

- Most routes require authentication.
- Use the `/auth/login` or `/auth/register` route to get an access token.
- Use the access token in the `Authorization` header of your requests.

## Additional Resources

- [readme](#../README.md)
- [Technologies](#Technologies.md)

### Communication Channels

- Discord
- Email

*This document is subject to change and will be updated as needed.*
