import '../models/trip.dart';

class TripState {
  const TripState({
    required this.trips,
    required this.filteredTrips,
    required this.searchQuery,
    required this.isLoading,
  });

  final List<Trip> trips;
  final List<Trip> filteredTrips;
  final String searchQuery;
  final bool isLoading;

  factory TripState.initial() {
    return const TripState(
      trips: [],
      filteredTrips: [],
      searchQuery: '',
      isLoading: true,
    );
  }

  TripState copyWith({
    List<Trip>? trips,
    List<Trip>? filteredTrips,
    String? searchQuery,
    bool? isLoading,
  }) {
    return TripState(
      trips: trips ?? this.trips,
      filteredTrips: filteredTrips ?? this.filteredTrips,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
