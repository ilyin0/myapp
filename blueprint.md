# Daily Horoscope App Blueprint

## Overview

This document outlines the architecture, features, and design of the Daily Horoscope mobile application. The app provides users with their daily horoscope prediction based on their selected zodiac sign. It is built with a clean, scalable architecture to facilitate future enhancements.

## Implemented Features, Style, and Design

### Architecture

The project follows a modern, layered architecture to ensure a clear separation of concerns:

*   **Data Layer:** Responsible for all data operations.
    *   `HoroscopeRemoteDataSource`: Handles the raw HTTP GET requests to the horoscope API.
    *   `DailyPredictDto`: A Data Transfer Object that maps the incoming JSON response to a Dart object.
    *   `HoroscopeDataRepository`: Implements the `HoroscopeRepository` interface. It calls the data source, receives the DTO, and maps it to a pure `DailyPredict` domain entity.

*   **Domain Layer:** The core of the application, containing the business logic and entities. It is completely independent of the other layers.
    *   `DailyPredict`: A pure entity representing the horoscope prediction.
    *   `ZodiacSign`: An enum for type-safe representation of the zodiac signs.
    *   `HoroscopeRepository`: An abstract interface defining the contract for fetching horoscope data.
    *   `GetDailyPredictUseCase`: Encapsulates the specific business logic of getting a daily prediction.

*   **Presentation Layer:** The UI layer of the application.
    *   `MainScreen`: A `StatefulWidget` that manages the UI state (loading, error, success) and user interactions.
    *   **Dependency Injection:** A simple, manual DI setup in `lib/di/di.dart` initializes and provides the necessary dependencies (`GetDailyPredictUseCase`) to the presentation layer.

### State Management

*   **`StatefulWidget`:** The application uses Flutter's built-in `setState()` for managing the simple, local state of the `MainScreen`. This is the most direct and efficient approach for the current scope.

### UI and Design

*   **Theme:** The app uses a modern Material 3 theme, configured centrally in `main.dart` using `ThemeData` and `ColorScheme.fromSeed` for a consistent look and feel. The primary color is based on `Colors.deepPurple`.
*   **`MainScreen` UI:**
    *   A clean and intuitive user interface.
    *   A `DropdownButtonFormField` allows users to select their zodiac sign. It is initialized to `null` to prompt manual user selection.
    *   An `ElevatedButton` triggers the API call to fetch the prediction. The button is disabled during the loading state and before a zodiac sign is selected.
    *   A `CircularProgressIndicator` provides visual feedback to the user while data is being fetched.
    *   The successful prediction is displayed inside a styled `Card`.
    *   Error messages are displayed clearly to the user in case of a failure.

## Current Development Plan

*There are no active development tasks. The application is stable in its initial version.*

