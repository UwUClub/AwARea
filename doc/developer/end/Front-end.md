# Frontend Development Documentation

## Introduction

This document provides an overview and guidelines for the frontend development of our project. It covers architecture, and best practices that our team follows.

## Table of Contents

- [Introduction](#introduction)
- [Architecture](#architecture)
- [Troubleshooting and Support](#troubleshooting-and-support)
- [Contributing](#contributing)
- [Additional Resources](#additional-resources)

## Development Guidelines

### Coding Standards

- Follow the default coding standards of [Flutter](https://flutter.dev/docs/development/tools/formatting).

### Component Architecture

- Follow the Flutter [component architecture](https://flutter.dev/docs/development/ui/widgets-intro).
- `main.dart` is the entry point of the application.
- `android` and `ios` folders contain the native code for Android and iOS respectively.
- `web` folder contains the web code for the application.
- `lib` folder contains the Dart code for the application.
- `lib/Core` folder contains the core code of the application.
    - `lib/Core/Locator/locator.dart` contains the locator for the application.
    - `lib/Core/Manager/X_manager` contains a manager for X service.

## Troubleshooting and Support

- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter Community](https://flutter.dev/community)
- [Flutter FAQ](https://flutter.dev/docs/resources/faq)

## Contributing

- [How to Contribute](Introduction.md#Pull-Request-Process)

## Additional Resources

- [Introduction](../Introduction.md)
- [Technologies](../Technologies.md)
- [API Documentation (back-end)](./Back-end.md)

---

*This document is subject to change and will be updated as needed.*
