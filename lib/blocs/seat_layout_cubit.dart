import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking_app/models/seat_layout_state_model.dart';

import '../models/seat_model.dart';
import '../models/seat_state.dart';

class SeatLayoutCubit extends Cubit<SeatLayoutStateModel> {
  SeatLayoutCubit()
      : super(const SeatLayoutStateModel(
          rows: 0,
          cols: 0,
          currentSeats: [[]],
        ));

  //? Initialize Seat Layout
  void updateRowAndColCount(
    int rows,
    int cols,
  ) {
    emit(state.copyWith(
      rows: rows,
      cols: cols,
      currentSeats: List.generate(
        rows,
        (rowI) => List.generate(
          cols,
          (colI) => SeatModel(
            seatState: SeatState.available,
            rowI: rowI,
            colI: colI,
          ),
        ),
      ),
    ));
  }

  //? To update a particular seat
  void updateSeatState(
    SeatModel seatModel,
  ) {
    final seatsState = state.deepCopyList(state.currentSeats);
    seatsState[seatModel.rowI][seatModel.colI] = seatModel;
    emit(state.copyWith(currentSeats: seatsState));
  }

  void updateCurrentSeatLayout(
    SeatLayoutStateModel seatLayout,
  ) {
    emit(seatLayout);
  }

  //? This allows select multiple seat in a row
  void selectSeats(
    SeatModel seatModel,
    int quantity,
    void Function(String msg) onErrorSnackBar,
  ) {
    final seats = state.deepCopyList(state.currentSeats);

    switch (seatModel.seatState) {
      case SeatState.available:
        if (quantity > SeatLayoutStateModel.getSelectedSeatsCount(seats)) {
          // Select as many as possible in current row
          for (int colI = seatModel.colI;
              colI < seats[seatModel.rowI].length;
              colI++) {
            if (quantity > SeatLayoutStateModel.getSelectedSeatsCount(seats)) {
              if (seats[seatModel.rowI][colI].seatState ==
                  SeatState.available) {
                seats[seatModel.rowI][colI] = SeatModel(
                  seatState: SeatState.selected,
                  rowI: seatModel.rowI,
                  colI: colI,
                );
              }
            } else {
              break;
            }
          }
          emit(state.copyWith(currentSeats: seats));
        } else {
          onErrorSnackBar("Already selected maximum seats");
        }

      case SeatState.selected:
        seats[seatModel.rowI][seatModel.colI] =
            seatModel.copyWith(seatState: SeatState.available);
        emit(state.copyWith(currentSeats: seats));

      case SeatState.occupied:
        onErrorSnackBar("Please select other option it is already occupied");
    }
  }

  //? This allows selecting only one seat
  void selectPartialSeats(
    SeatModel seatModel,
    int quantity,
    void Function(String msg) onErrorSnackBar,
  ) {
    final seats = state.deepCopyList(state.currentSeats);

    switch (seatModel.seatState) {
      case SeatState.available:
        if (quantity > SeatLayoutStateModel.getSelectedSeatsCount(seats)) {
          seats[seatModel.rowI][seatModel.colI] =
              seatModel.copyWith(seatState: SeatState.selected);
          emit(state.copyWith(currentSeats: seats));
        } else {
          onErrorSnackBar("Already selected maximum seats");
        }

      case SeatState.selected:
        seats[seatModel.rowI][seatModel.colI] =
            seatModel.copyWith(seatState: SeatState.available);
        emit(state.copyWith(currentSeats: seats));

      case SeatState.occupied:
        onErrorSnackBar("Please select other option it is already occupied");
    }
  }

  //? This will deselects seats and make them available again
  void updateSelectedSeatsToAvailable() {
    var updatedSeats =
        state.deepCopyList(state.currentSeats); // Create a deep copy

    for (int rowI = 0; rowI < updatedSeats.length; rowI++) {
      for (int colI = 0; colI < updatedSeats[rowI].length; colI++) {
        if (updatedSeats[rowI][colI].seatState == SeatState.selected) {
          updatedSeats[rowI][colI] = updatedSeats[rowI][colI].copyWith(
            seatState: SeatState.available,
          );
        }
      }
    }
    emit(
      state.copyWith(
        currentSeats: updatedSeats,
      ),
    );
  }

  //? This will update selected seats to occupied seats
  void bookSeats(
    SeatLayoutStateModel selectedSeatLayout,
  ) {
    var updatedSeats = state
        .deepCopyList(selectedSeatLayout.currentSeats); // Create a deep copy

    for (int rowI = 0; rowI < updatedSeats.length; rowI++) {
      for (int colI = 0; colI < updatedSeats[rowI].length; colI++) {
        if (updatedSeats[rowI][colI].seatState == SeatState.selected) {
          updatedSeats[rowI][colI] = updatedSeats[rowI][colI].copyWith(
            seatState: SeatState.occupied,
          );
        }
      }
    }
    emit(
      selectedSeatLayout.copyWith(
        currentSeats: updatedSeats,
      ),
    );
  }
}
