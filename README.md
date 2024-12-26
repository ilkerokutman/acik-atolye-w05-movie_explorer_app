# Week 5 - Movie Explorer App

This is the starter project for the **Week 5 Movie Explorer App** in the Flutter course.  
The app demonstrates making network requests and handling API data using **Dio** and **http** libraries.

---

## Features

- **Fetch Movies**:
  - Fetches a list of movies from the TMDB API (or mock data if API keys are not available).
- **Movie Details**:
  - Displays detailed information about a selected movie.
- **Dynamic UI**:
  - The list and detail views are populated dynamically based on API responses.

---

## Concepts Covered

- **HTTP Requests**:
  - Fetching data from RESTful APIs using the `http` package.
- **Advanced Dio Features**:
  - Base options for API configuration.
  - Interceptors for logging and error handling.
  - Efficient API error management.
- **Parsing JSON Data**:
  - Working with API responses to populate the UI dynamically.
- **Widget Tree Composition**:
  - Structuring widgets for clean and maintainable code.

---

## Project Structure

- **Main Code**: Located in `lib/main.dart`.
- **Screens**:
  - `movie_list_screen.dart`: Displays a list of movies fetched from the API.
  - `movie_detail_screen.dart`: Shows detailed information about a selected movie.
- **Services**:
  - API integration handled in a `movie_api_service.dart` file.
- **Models**:
  - Data parsed into Dart models for easier manipulation.

---

## Development Steps

This repository contains multiple commits, each representing a milestone in the app's development.  
You can roll back to any state to follow along with the class:

1. **Initial Template**: Empty Flutter app.
2. **HTTP Setup**: Configure `http` for basic API requests.
3. **Switch to Dio**: Replace `http` with Dio for advanced networking features.
4. **Movie List Screen**: Display movies fetched from the API.
5. **Movie Details Screen**: Add detailed views for selected movies.
6. **Final App**: Completed Movie Explorer App with robust API integration.

Use the following command to check out a specific commit:
```bash
git checkout <commit-hash>
```

---

## Getting Started

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/ilkerokutman/acik-atolye-w05-movie_explorer_app.git
   ```
2. **Navigate to the Project Directory**:
   ```bash
   cd w05-movie-explorer-app
   ```
3. **Run the App**:
   - Ensure you have Flutter installed.
   - Add your TMDB API key in the appropriate configuration file.
   - Use the command:
     ```bash
     flutter run
     ```

---

## Contribution

Please refer to the [CONTRIBUTION.md](CONTRIBUTION.md) file for guidelines on contributing to this repository.

---

## License

This project is licensed under the [MIT License](LICENSE).
