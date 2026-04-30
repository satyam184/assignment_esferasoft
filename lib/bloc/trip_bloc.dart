import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/trip.dart';
import 'trip_event.dart';
import 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(TripState.initial()) {
    on<LoadTrips>(_onLoadTrips);
    on<SearchTrips>(_onSearchTrips);
    on<UpdateTripStatus>(_onUpdateTripStatus);

    add(const LoadTrips());
  }

  static const List<Map<String, dynamic>> _tripJson = [
    {
      'id': 1,
      'title': 'Downtown Seattle to Sea-Tac',
      'date': '2026-01-20',
      'pickup': 'Hotel A',
      'drop': 'Sea-Tac',
      'status': TripStatus.booked,
    },
    {
      'id': 2,
      'title': 'Sea-Tac to Downtown Seattle',
      'date': '2026-01-22',
      'pickup': 'Sea-Tac',
      'drop': 'Hotel B',
      'status': TripStatus.completed,
    },
    {
      'id': 3,
      'title': 'Private Car: Bellevue to Sea-Tac',
      'date': '2026-01-25',
      'pickup': 'Bellevue',
      'drop': 'Sea-Tac',
      'status': TripStatus.booked,
    },
  ];

  void _onLoadTrips(LoadTrips event, Emitter<TripState> emit) {
    final trips = _tripJson.map(Trip.fromJson).toList();
    emit(
      state.copyWith(
        trips: trips,
        filteredTrips: trips,
        searchQuery: '',
        isLoading: false,
      ),
    );
  }

  void _onSearchTrips(SearchTrips event, Emitter<TripState> emit) {
    emit(
      state.copyWith(
        searchQuery: event.query,
        filteredTrips: _filterTrips(state.trips, event.query),
      ),
    );
  }

  void _onUpdateTripStatus(
    UpdateTripStatus event,
    Emitter<TripState> emit,
  ) {
    final updatedTrips = state.trips
        .map(
          (trip) => trip.id == event.tripId
              ? trip.copyWith(status: event.status)
              : trip,
        )
        .toList();

    emit(
      state.copyWith(
        trips: updatedTrips,
        filteredTrips: _filterTrips(updatedTrips, state.searchQuery),
      ),
    );
  }

  List<Trip> _filterTrips(List<Trip> trips, String query) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return trips;
    }

    return trips
        .where(
          (trip) => trip.title.toLowerCase().contains(normalizedQuery),
        )
        .toList();
  }
}
