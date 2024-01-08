# AwArea

## Contents

-   [Requirements](#requirements)
-   [Communication](#communication)
-   [Services](#services)
-   [Installation from source](#installation-from-source)
-   [Using the application](#using-the-application)
-   [Troubleshooting](#troubleshooting)
-   [Credits](#credits)
-   [License](#license)

## Requirements

-   Node.js
-   Npm
-   Flutter

## Communication

-   If you have a bug or an issue, please contact us.

## Services

-   [x] Timer -> 2 actions -> Recurring / One time
-   [x] Weather -> 1 action -> OnGetWeather
-   [x] Nasa -> 1 action -> OnGetPicture
-   [x] GMail -> 2 actions -> OnNewMail / OnNewMailFrom / WriteMail
-   [x] Github
-   [x] Slack

## Installation from source

### SSH

```bash
git clone git@github.com:UwUClub/AwArea.git
```

## Using the application

### Server

First start the server

```bash
cd api && npm install && npmstart
```

### Client

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

## Credits

-   Valentin Gegoux
-   Quentin Challon
-   Luca Deltort
-   Maxence Labourel
-   Baptiste Laran

## License

AwArea is developped by the UwUClub for Epitech.
