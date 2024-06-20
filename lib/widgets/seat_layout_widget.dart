import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/seat_layout_state_model.dart';
import '../models/seat_model.dart';
import '../models/seat_state.dart';
import 'seat_card.dart';

class SeatLayoutWidget extends StatelessWidget {
  final SeatLayoutStateModel seatLayout;
  final Function(SeatModel seatModel) onTap;
  final Function(SeatModel seatModel)? onDoubleTap;

  const SeatLayoutWidget({
    super.key,
    required this.seatLayout,
    required this.onTap,
    this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SvgPicture.asset(
          "assets/screen.svg",
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
          width: MediaQuery.of(context).size.width,
          height: 40,
        ),
        const SizedBox(height: 8),
        Text(
          "Screen Here",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: InteractiveViewer(
              maxScale: 5,
              minScale: 0.6,
              boundaryMargin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 2,
                vertical: MediaQuery.of(context).size.height / 4,
              ),
              constrained: false,
              child: Column(
                children: [
                  ...List<int>.generate(
                    seatLayout.rows,
                    (rowI) => rowI,
                  ).map<Row>(
                    (rowI) => Row(
                      children: [
                        ...List<int>.generate(
                          seatLayout.cols,
                          (colI) => colI,
                        ).map(
                          (colI) {
                            SeatState seatState =
                                seatLayout.currentSeats[rowI][colI].seatState;
                            return Padding(
                              padding: EdgeInsets.only(
                                right: (colI + 1) % 3 == 0
                                    ? 32
                                    : seatLayout.cols - 1 == colI
                                        ? 0
                                        : 8,
                                bottom: (rowI + 1) % 4 == 0
                                    ? 32
                                    : seatLayout.rows - 1 == rowI
                                        ? 0
                                        : 12,
                              ),
                              child: SeatCard(
                                seatModel: SeatModel(
                                  seatState: seatState,
                                  rowI: rowI,
                                  colI: colI,
                                ),
                                onTap: onTap,
                                onDoubleTap: onDoubleTap,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SeatTypeInfoWidget(
              seatState: SeatState.occupied,
            ),
            SizedBox(width: 16),
            SeatTypeInfoWidget(
              seatState: SeatState.available,
            ),
            SizedBox(width: 16),
            SeatTypeInfoWidget(
              seatState: SeatState.selected,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SeatTypeInfoWidget extends StatelessWidget {
  final SeatState seatState;
  const SeatTypeInfoWidget({required this.seatState, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/seat.svg",
          colorFilter: ColorFilter.mode(
            seatState.color(context),
            BlendMode.srcIn,
          ),
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        Text(
          seatState.val,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
