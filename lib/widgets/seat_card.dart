import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seat_booking_app/models/seat_model.dart';
import 'package:seat_booking_app/models/seat_state.dart';

class SeatCard extends StatelessWidget {
  final SeatModel seatModel;
  final Function(SeatModel seatModel) onTap;
  final Function(SeatModel seatModel)? onDoubleTap;

  const SeatCard({
    required this.seatModel,
    required this.onTap,
    required this.onDoubleTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(seatModel);
      },
      onDoubleTap: onDoubleTap == null
          ? null
          : () {
              onDoubleTap!(seatModel);
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 32,
        height: 32,
        // decoration: BoxDecoration(
        //   border: Border.all(width: 1),
        //   borderRadius: BorderRadius.circular(4),
        //   color: seatModel.seatState.color(context),
        // ),
        child: Center(
          // child: Text(
          //   seatModel.colI.toString(),
          //   style: TextStyle(
          //     color: switch (seatModel.seatState) {
          //       SeatState.available => Colors.black,
          //       SeatState.occupied || SeatState.selected => Colors.white,
          //     },
          //   ),
          // ),
          child: SvgPicture.asset(
            "assets/seat.svg",
            colorFilter: ColorFilter.mode(
              seatModel.seatState.color(context),
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
