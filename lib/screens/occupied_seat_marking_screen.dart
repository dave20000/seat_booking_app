import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking_app/blocs/seat_layout_cubit.dart';
import 'package:seat_booking_app/models/seat_layout_state_model.dart';
import 'package:seat_booking_app/models/seat_model.dart';
import 'package:seat_booking_app/widgets/custom_app_bar.dart';
import 'package:seat_booking_app/widgets/seat_layout_widget.dart';

import '../models/seat_state.dart';
import 'book_quantity_screen.dart';

class OccupiedSeatMarkingScreen extends StatelessWidget {
  const OccupiedSeatMarkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatLayoutCubit, SeatLayoutStateModel>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Occupied Seat Marking Screen',
          ),
          body: SeatLayoutWidget(
            seatLayout: state,
            onTap: (seatModel) {
              context.read<SeatLayoutCubit>().updateSeatState(
                    SeatModel(
                      seatState: seatModel.seatState == SeatState.occupied
                          ? SeatState.available
                          : SeatState.occupied,
                      rowI: seatModel.rowI,
                      colI: seatModel.colI,
                    ),
                  );
            },
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: () {
                      context
                          .read<SeatLayoutCubit>()
                          .updateCurrentSeatLayout(state);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingQuantityScreen(),
                        ),
                      );
                    },
                    child: const Text('Next'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
