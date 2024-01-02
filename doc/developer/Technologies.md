# Choice of Technologies

-   [NestJS](#nestjs)
    -   [Swagger](#swagger)
    -   [Schedule](#schedule)
-   [Flutter](#flutter)
    -   [stacked](#stacked)
    -   [get_it](#get_it)
    -   [flutter_localizations](#flutter_localizations)
    -   [intl](#intl)
-   [MongoDB](#mongodb)
    -   [Mongoose](#mongoose)
-   [Passport](#passport)
-   [Class Validator and Class Transformer](#class-validator-and-class-transformer)
-   [bcrypt](#bcrypt)
-   [JWT](#jwt)

## NestJS

-   Scalability and Performance: NestJS is built on Node.js and uses TypeScript, offering a scalable architecture that can handle a large number of simultaneous connections with high performance. This is crucial for ensuring that our API can support the growing number of users and data.

-   TypeScript Advantage: The use of TypeScript in NestJS provides strong typing and object-oriented programming, which enhances code quality and maintainability. This leads to fewer bugs and a stable API in the long run.

-   Modular Structure: NestJS promotes code organization and reusability. This makes it easier to manage and scale the project as it grows, and also facilitates easier maintenance and updates.

-   Rich Ecosystem and Integrations: NestJS has a rich ecosystem and integrates well with other libraries and databases, providing flexibility and making it an easy choice for our project.

-   Documentation: NestJS has a comprehensive and well-organized documentation, which is crucial for learning, understanding and using the framework.

### Swagger

-   Swagger is a tool that can be used to document APIs. It provides a user-friendly interface for developers to view and test the API endpoints, and also generates documentation for the API. This is used to ensure that our API is well-documented and easy to use.

### Schedule

-   NestJS provides a built-in scheduler that can be used to run tasks at regular intervals. This is used to schedule the sending of notifications to users.
-   It replaces the "Cron" package that was previously used for scheduling.
-   The scheduler is used to refresh all the access tokens.

## Flutter

-   Cross-Platform Development: Flutter allows us to write a single codebase for iOS and Android apps, as well as for web applications. This leads to faster development and easier maintenance, as we do not need to maintain separate codebases for each platform.

-   Consistent UI and Performance: Flutter provides a consistent UI across all platforms, and its high-performance rendering engine ensures a smooth user experience. This is crucial for ensuring that our app is visually appealing on each platform and performs well.

-   Rich Set of Widgets: Flutter comes with a rich set of pre-designed widgets that follow modern design standards, allowing us to create visually appealing and intuitive interfaces quickly.

-   Hot Reload Feature: The hot reload feature in Flutter enhances developer productivity by allowing instant viewing of changes without needing a full reload. This speeds up the development process and allows for rapid iteration.

-   Documentation: Flutter is made by Google, it has a very good and easy to understand documentation.

### stacked

-   MVVM Architecture: Stacked follows the Model-View-ViewModel (MVVM) architectural model, helping to structure code more organizedly, separating business logic from the user interface.
    
-   State Management: It provides simplified state management essential for medium to large-scale applications.

-   Reactivity: Stacked facilitates the creation of reactive user interfaces that respond to state changes effectively.

-   Services and Dependency Injection: It allows easy integration of services and uses dependency injection for better modularity and testability of the code.

### get_it

-   Service Locator: GetIt is a service locator for Dart and Flutter, meaning it can be used to retrieve instances of your classes wherever needed in your application.

-   Decoupled Dependencies: It helps to decouple instance creation logic and instance usage, beneficial for code maintenance and testing.

-   Singletons and Lazy Singletons: GetIt allows for easy configuration of singletons and lazy singletons, useful for managing instances that need to be unique throughout the application.

-   Flexibility: GetIt offers great flexibility in dependency management, suited to many development scenarios.

### flutter_localizations

-   Multi-Language Support: This package enables adding support for multiple languages in your Flutter application.

-   Integrated Localization: It offers tight integration with the Flutter framework, making it easier to localize texts, dates, numbers, and more.

-   Regional Format Support: It helps manage regional formats for dates, times, and numbers, crucial for applications intended for an international audience.

### intl

-   Internationalization and Localization: The Intl package provides tools for internationalizing and localizing applications, including support for date, number, and message formats.

-   Date and Time Manipulation: It is particularly useful for formatting and parsing dates and times locally.

-   Pluralization and Gender: Intl helps manage pluralization and gender selection in texts, essential for accurate localization.

-   Flexibility and Customization: It offers great flexibility in defining custom formats and managing localized messages.

## MongoDB

-   Flexibility and Scalability: MongoDB is a NoSQL database that offers high flexibility with its schema-less structure. This is ideal since our data structures can evolve over time. It also can handle large amounts of data and scale horizontally.

-   JSON Data Format: MongoDB uses a JSON-like format for storing data, which aligns well with JavaScript-based technologies (like Node.js in NestJS). This makes it easy to work with and integrate with our backend.

### Mongoose

-   Data Modeling and Validation: Mongoose provides a straightforward solution for data modeling in MongoDB. It allows defining schemas for your data, which includes built-in type casting, validation, and query building.

-   Ease of Use: Mongoose simplifies the interaction with MongoDB through its object modeling and provides a more intuitive and higher-level API for database operations.

## Passport

-   Authentication: Passport is a popular authentication middleware for Node.js. It provides a simple and flexible way to authenticate users using different strategies (e.g. local, OAuth, etc.). This is used to authenticate users for our API.

-   Security: Passport provides a secure way to authenticate users by using a session store (e.g. Redis) and encrypting sensitive data (e.g. passwords). This is crucial for ensuring that our API is secure.

## Class Validator and Class Transformer

-   Validation: Class Validator and Class Transformer are used to validate and transform data in our API. This is crucial for ensuring that the data sent to our API is valid and conforms to the expected format.

## bcrypt

-   Password Hashing: bcrypt is a popular password hashing library for Node.js. It provides a secure way to store passwords by using a salted hash. This is used to securely store user passwords in our database.

-   Security: bcrypt provides a secure way to store passwords by using a salted hash. This is crucial for ensuring that our API is secure.

## JWT

-   Authentication: JWT is a popular authentication mechanism for web applications. It provides a secure way to authenticate users by using a JSON Web Token (JWT). This is used to authenticate users for our API.

-   Security: JWT provides a secure way to authenticate users by using a JSON Web Token (JWT). This is crucial for ensuring that our API is secure.

## Nest config

-   Security: Keep all secrets and privates variable in the environement and manage them
