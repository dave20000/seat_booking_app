import 'package:seat_booking_app/models/seat_model.dart';

import 'seat_state.dart';

class SeatLayoutStateModel {
  final int rows;
  final int cols;
  final List<List<SeatModel>> currentSeats;

  const SeatLayoutStateModel({
    required this.rows,
    required this.cols,
    required this.currentSeats,
  });

  static int getSelectedSeatsCount(List<List<SeatModel>> seats) => seats
      .expand((i) => i)
      .where((val) => val.seatState == SeatState.selected)
      .length;

  static int getAvailableSeatsCount(List<List<SeatModel>> seats) => seats
      .expand((i) => i)
      .where((val) => val.seatState == SeatState.available)
      .length;

  SeatLayoutStateModel copyWith({
    int? rows,
    int? cols,
    List<List<SeatModel>>? currentSeats,
  }) {
    return SeatLayoutStateModel(
      rows: rows ?? this.rows,
      cols: cols ?? this.cols,
      currentSeats: currentSeats ?? deepCopyList(this.currentSeats),
    );
  }

  List<List<SeatModel>> deepCopyList(List<List<SeatModel>> list) {
    return list.map((innerList) => List<SeatModel>.from(innerList)).toList();
  }
}
