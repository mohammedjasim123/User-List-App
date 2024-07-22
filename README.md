# user_list

The User List App is a Flutter application that displays a list of users from API, with a search functionality. Users can switch between dark and light themes using a toggle button in the app bar. The app fetches user data using the BLoC pattern for state management.

## Features

- Display a list of users with their details.
- Search users by name or email.
- Pull-to-refresh functionality to reload user data.
- Toggle between dark and light themes.

## Installation

1. **Clone the repository**
    ```sh
    git clone https://github.com/your-username/user-list-app.git
    cd user-list-app
    ```

2. **Install dependencies**
    ```sh
    flutter pub get
    ```

3. **Run the app**
    ```sh
    flutter run
    ```

## Folder Structure

- `lib/`
  - `blocs/`: Contains the BLoC classes (`user_bloc.dart`, `user_event.dart`, `user_state.dart`).
  - `repositories/`: Contains the repository class (`user_repository.dart`).
  - `themes/`: Contains the theme data (`themes.dart`).
  - `widgets/`: Contains reusable widgets (`user_card.dart`).
  - `src/`: Contains source files (`user_list_screen.dart`).
  - `main.dart`: Entry point of the application.
