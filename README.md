# AwArea

## Contents

-   [Requirements](#requirements)
-   [Communication](#communication)
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

## Installation from source

### SSH

```bash
git clone git@github.com:UwUClub/AwArea.git
```

## Using the application

### Server

First start the server

```bash
cd api && pnpm install && pnpm start
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

And add ``'--disable-web-security'`` under ``'--disable-extensions'`` in ``{your_flutter_directory}/packages/flutter_tools/lib/src/web/chrome.dart``

## Credits

-   Valentin Gegoux
-   Baptiste Laran
-   Quentin Challon
-   Luca Deltort
-   Maxence Labourel

## License

AwArea is developped by the UwUClub for Epitech.
