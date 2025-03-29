# Dependency Injection (DI) for Dart

A simple and lightweight Dependency Injection (DI) container for Dart. This library helps manage service registration and retrieval in a clean, maintainable way, following the Singleton and Factory design patterns.

## Features

- **Singleton Registration:** Register services as singletons to ensure a single instance throughout the application.
- **Factory Registration:** Register services as factories to create a new instance every time.
- **Type-Safe Retrieval:** Retrieve services by their type with automatic instantiation.

## Installation

Add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  di: ^1.0.0
