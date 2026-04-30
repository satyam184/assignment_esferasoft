import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/trip_bloc.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TripsBookingsApp());
}

class TripsBookingsApp extends StatelessWidget {
  const TripsBookingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TripBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trips & Bookings',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          scaffoldBackgroundColor: const Color(0xFFF7F9FC),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
