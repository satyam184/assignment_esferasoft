abstract class TripEvent {
  const TripEvent();
}

class LoadTrips extends TripEvent {
  const LoadTrips();
}

class SearchTrips extends TripEvent {
  const SearchTrips(this.query);

  final String query;
}

class UpdateTripStatus extends TripEvent {
  const UpdateTripStatus({
    required this.tripId,
    required this.status,
  });

  final int tripId;
  final String status;
}
