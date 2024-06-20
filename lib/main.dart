import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking_app/blocs/seat_layout_cubit.dart';

import 'screens/venue_setup_screen.dart';

void main() {
  runApp(
    const SeatBookingApp(),
  );
}

class SeatBookingApp extends StatelessWidget {
  const SeatBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocProvider(
        create: (_) => SeatLayoutCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Seat Booking App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const VenueSetupScreen(),
          // home: const CinemaHall(),
        ),
      ),
    );
  }
}
