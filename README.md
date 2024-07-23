# User List App

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

## Screenshots
![Dark Mode](screenshots\dark_mode.png)
![Light Mode](screenshots\light_mode.png)
![Search User](screenshots\search_user.png)



## Folder Structure

- `lib/`
  - `blocs/`: Contains the BLoC classes (`user_bloc.dart`, `user_event.dart`, `user_state.dart`).
  - `repositories/`: Contains the repository class (`user_repository.dart`).
  - `themes/`: Contains the theme data (`themes.dart`).
  - `widgets/`: Contains reusable widgets (`user_card.dart`).
  - `src/`: Contains source files (`user_list_screen.dart`).
  - `main.dart`: Entry point of the application.
 
## Assumptions
- **Togle theme** : Dark and light modes
- **Search bar**: Suggestions while searching the users

## Usage

1. **Home Screen**: Displays a list of users. Use the search bar to filter users by name or email.
2. **Pull-to-Refresh**: Pull down on the list to refresh the user data.
3. **Toggle Theme**: Use the toggle button in the app bar to switch between dark and light themes.
4. **Loading Indicator**: A loading indicator is displayed while user data is being fetched.

