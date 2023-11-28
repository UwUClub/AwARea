# Choice of Technologies

-   [NestJS](#nestjs)
    -   [Swagger](#swagger)
    -   [Schedule](#schedule)
-   [Flutter](#flutter)

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
