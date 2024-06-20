import 'package:flutter/material.dart';

import '../models/seat_model.dart';

class ConfirmationScreen extends StatelessWidget {
  final List<SeatModel> bookedSeats;

  const ConfirmationScreen({
    required this.bookedSeats,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        Navigator.of(context).popUntil(
          (route) => route.isFirst,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Confirmation'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Thank you for purchasing your movie tickets with us. We hope you enjoy your movie experience.",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Total Seats Booked: ${bookedSeats.length}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        fixedSize: const Size.fromHeight(60),
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      onPressed: () {
                        Navigator.of(context).popUntil(
                          (route) => route.isFirst,
                        );
                      },
                      child: const Text('Start Again'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        fixedSize: const Size.fromHeight(60),
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Book More Seats'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
