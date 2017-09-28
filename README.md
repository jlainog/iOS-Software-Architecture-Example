# iOS-Software-Architecture-Example

This Code is an example presented as part of the presentation
#### A Brief Understanding of Software Architecture
which supports the idea of make your architecture based on Use Cases to ease the definitions of well crafted interfaces,
that detail the use case and expose the minimun functions and variables needed for it use.

## Description
This app shows 3 list of movies, each list presented using a different pattern (MVC, MVP, MVVM).
Having differents implementations for the [Use Case](https://en.wikipedia.org/wiki/Use_case) (ListMovies) represetend by a protocol, following the
the [Dependency Inversion Principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle).

The Use Case is injected to the Controller, Presenter and ViewModel for them to request the needed info and proccess the representation
of the data to be delivered to the UI, making the UI as ignorant as posible and segregating the UI for each case following the
[Interface Segregation Principle](https://drive.google.com/file/d/0BwhCYaYDn8EgOTViYjJhYzMtMzYxMC00MzFjLWJjMzYtOGJiMDc5N2JkYmJi/view)

## License

MIT License
