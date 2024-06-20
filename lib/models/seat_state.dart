import 'package:flutter/material.dart';

enum SeatState {
  available(val: "Available"),
  occupied(val: "Occupied"),
  selected(val: "Selected");

  const SeatState({required this.val});

  final String val;
}

extension SeatStateExtension on SeatState {
  Color color(BuildContext context) => switch (this) {
        SeatState.available => const Color(0xFFD9D9D9),
        SeatState.occupied => Theme.of(context).colorScheme.secondary,
        SeatState.selected => Theme.of(context).colorScheme.primary,
      };
}
