import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking_app/blocs/seat_layout_cubit.dart';
import 'package:seat_booking_app/models/seat_layout_state_model.dart';

import '../models/seat_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/seat_layout_widget.dart';
import 'confirmation_screen.dart';

class SeatSelectionScreen extends StatelessWidget {
  final int quantity;
  const SeatSelectionScreen({
    required this.quantity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatLayoutCubit, SeatLayoutStateModel>(
      builder: (context, state) {
        return PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            context.read<SeatLayoutCubit>().updateSelectedSeatsToAvailable();
          },
          child: Scaffold(
            appBar: const CustomAppBar(
              title: 'Seat Selection Screen',
            ),
            body: Column(
              children: [
                Expanded(
                  child: SeatLayoutWidget(
                    seatLayout: state,
                    onTap: (seatModel) {
                      context.read<SeatLayoutCubit>().selectSeats(
                        seatModel,
                        quantity,
                        (String msg) {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 400),
                                content: Text(msg),
                              ),
                            );
                        },
                      );
                    },
                    onDoubleTap: (seatModel) {
                      context.read<SeatLayoutCubit>().selectPartialSeats(
                        seatModel,
                        quantity,
                        (String msg) {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 400),
                                content: Text(msg),
                              ),
                            );
                        },
                      );
                    },
                  ),
                ),
              ],
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Total",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Text(
                          "${SeatLayoutStateModel.getSelectedSeatsCount(state.currentSeats)} Seats",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 20000),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeInOut,
                      child: SeatLayoutStateModel.getSelectedSeatsCount(
                                  state.currentSeats) ==
                              quantity
                          ? FilledButton(
                              style: FilledButton.styleFrom(
                                fixedSize:
                                    const Size.fromWidth(double.maxFinite),
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                              ),
                              onPressed: () {
                                final bookedSeats = state.currentSeats
                                    .expand((i) => i)
                                    .where((val) =>
                                        val.seatState == SeatState.selected)
                                    .toList();

                                context
                                    .read<SeatLayoutCubit>()
                                    .bookSeats(state);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConfirmationScreen(
                                      bookedSeats: bookedSeats,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Book'),
                            )
                          : FilledButton(
                              onPressed: null,
                              style: FilledButton.styleFrom(
                                fixedSize:
                                    const Size.fromWidth(double.maxFinite),
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                              ),
                              child: const Text('Book'),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
