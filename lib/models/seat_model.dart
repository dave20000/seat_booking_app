import 'seat_state.dart';

class SeatModel {
  final SeatState seatState;
  final int rowI;
  final int colI;

  const SeatModel({
    required this.seatState,
    required this.rowI,
    required this.colI,
  });

  SeatModel copyWith({
    SeatState? seatState,
    int? rowI,
    int? colI,
  }) {
    return SeatModel(
      seatState: seatState ?? this.seatState,
      rowI: rowI ?? this.rowI,
      colI: colI ?? this.colI,
    );
  }
}
