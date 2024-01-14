# AwArea

## Contents

-   [Requirements](#requirements)
-   [Communication](#communication)
-   [Services](#services)
-   [Installation from source](#installation-from-source)
-   [Using the application](#using-the-application)
-   [Troubleshooting](#troubleshooting)
-   [Documentation](#documentation)
-   [Credits](#credits)
-   [License](#license)

## Requirements

| Language / Tools | Link | Description |
|:---:|:---:|:---:|
| [![My Skills](https://skillicons.dev/icons?i=docker)](Docker) | [**Docker**](https://www.docker.com/) | Docker is used to containerize the application, the api and the database. |
| [![My Skills](https://skillicons.dev/icons?i=mongodb)](MongoDB) | [**MongoDB**](https://www.mongodb.com/) | MongoDB is used as the database for the application. (not mandatory if using Docker) |
| [![My Skills](https://skillicons.dev/icons?i=nodejs)](NodeJS) | [**NodeJS**](https://nodejs.org/en/) | NodeJS is used to run the application. (not mandatory if using Docker) |
| [![My Skills](https://skillicons.dev/icons?i=typescript)](TypeScript) | [**TypeScript**](https://www.typescriptlang.org/) | TypeScript is used to write the application. |
| [![My Skills](https://skillicons.dev/icons?i=flutter)](Flutter) | [**Flutter**](https://flutter.dev/) | Flutter is used to write the mobile application. |
| [![My Skills](https://skillicons.dev/icons?i=git)](Git) | [**Git**](https://git-scm.com/) | Git is used for version control. |
---

## Communication

-   If you have a bug or an issue, please contact us.

## Services

-   [x] Timer
-   [x] Weather
-   [x] Nasa
-   [x] GMail
-   [x] Github
-   [x] Slack

## Installation from source

### SSH

```bash
git clone git@github.com:UwUClub/AwArea.git
```

## Using the application

### Docker

- use in the root directory
```bash
docker-compose up --build
```

### Manual

#### Server

First start the server

```bash
cd api && npm install && npm start
```

#### Client

Then start the client

```bash
cd flutter_area && flutter pub get && flutter run
```

## Troubleshooting

If you get blocked by CORS policy on Chrome:

```bash
rm {your_flutter_directory}/bin/cache/flutter_tools.stamp
```

And add `'--disable-web-security'` under `'--disable-extensions'` in `{your_flutter_directory}/packages/flutter_tools/lib/src/web/chrome.dart`

## Documentation

-   [User documentation to use Slack](doc/user/HowToMakeSlackApp.md)
-   [Developer](doc/developer/Introduction.md)

## Credits

-   Valentin Gegoux
-   Quentin Challon
-   Luca Deltort
-   Maxence Labourel
-   Baptiste Laran

## License

AwArea is developped by the UwUClub for Epitech.
