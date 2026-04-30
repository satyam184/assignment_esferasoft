# Trips & Bookings

Trips & Bookings is a small Flutter app with a simple login screen, a trip list, search, and trip status updates for booked trips.

## What the app does

- Validates email and password on the login screen
- Shows a list of trips on the home screen
- Filters trips by title using the search field
- Opens trip details and lets you update a booked trip to completed or cancelled

## How to run

1. Run `flutter pub get`
2. Run `flutter run`

## BLoC usage

- `TripBloc` loads the static trip data
- `SearchTrips` filters the list in memory
- `UpdateTripStatus` updates the selected trip and refreshes the filtered list

The login screen uses simple local validation to keep the app straightforward.

# assignment_esferasoft
