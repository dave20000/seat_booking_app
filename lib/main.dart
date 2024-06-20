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

// class CinemaHall extends StatefulWidget {
//   const CinemaHall({super.key});

//   @override
//   State<CinemaHall> createState() => _CinemaHallState();
// }

// class _CinemaHallState extends State<CinemaHall> with TickerProviderStateMixin {
//   late List<Offset> positions;
//   late List<ValueNotifier<bool>> states;

//   @override
//   void initState() {
//     super.initState();
//     const rows = 16;
//     const cols = 24;

//     positions = [
//       for (int r = 1; r <= rows; r++)
//         ...List.generate(
//             cols, (index) => (Offset(index.toDouble(), r.toDouble()))),
//     ];
//     states = List.generate(positions.length, (index) => ValueNotifier(false));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ColoredBox(
//       color: const Color(0xff000044),
//       child: InteractiveViewer(
//         minScale: 1.0,
//         maxScale: 3.0,
//         child: CustomMultiChildLayout(
//           delegate: CinemaHallDelegate(positions, const Size(64, 64)),
//           children: List.generate(
//               positions.length,
//               (index) => LayoutId(
//                   id: index,
//                   child: FittedBox(
//                     child: ValueListenableBuilder<bool>(
//                         valueListenable: states[index],
//                         builder: (context, state, child) {
//                           return TweenAnimationBuilder<double>(
//                               duration: const Duration(milliseconds: 500),
//                               tween: Tween(end: state ? 0.8 : 0.2),
//                               builder: (context, t, child) {
//                                 return IconButton(
//                                   icon: Icon(
//                                       index == 43 ? Icons.people : Icons.person,
//                                       color: Colors.white.withOpacity(t)),
//                                   padding: EdgeInsets.zero,
//                                   iconSize: 64,
//                                   tooltip:
//                                       'seat ${positions[index].dy.toInt() + 1}, ${positions[index].dx.toInt() + 1}',
//                                   onPressed: () {
//                                     states[index].value = !state;
//                                     print(index);
//                                   },
//                                 );
//                               });
//                         }),
//                   ))),
//         ),
//       ),
//     );
//   }
// }

// class CinemaHallDelegate extends MultiChildLayoutDelegate {
//   final List<Offset> positions;
//   final Size seatSize;
//   late Size cinemaHallSize;

//   CinemaHallDelegate(this.positions, this.seatSize) : super() {
//     double cols = positions.map((o) => o.dx).reduce(max) + 1;
//     double rows = positions.map((o) => o.dy).reduce(max) + 1;
//     cinemaHallSize = Size(cols * seatSize.width, rows * seatSize.height);
//   }

//   @override
//   void performLayout(Size size) {
//     final matrix = sizeToRect(cinemaHallSize, Offset.zero & size);
//     final seatRect = MatrixUtils.transformRect(matrix, Offset.zero & seatSize);
//     final center =
//         size.center(Offset(-seatRect.width / 2, -seatRect.height / 2));

//     int childId = 0;
//     final constraints =
//         BoxConstraints.tight(Size(seatRect.width, seatRect.height));
//     for (final position in positions) {
//       layoutChild(childId, constraints);
//       final offset = Offset(seatRect.left + position.dx * seatRect.width,
//           seatRect.top + position.dy * seatRect.height);
//       positionChild(childId, offset);
//       childId++;
//     }
//   }

//   @override
//   bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
// }

// Matrix4 sizeToRect(
//   Size src,
//   Rect dst, {
//   BoxFit fit = BoxFit.contain,
//   Alignment alignment = Alignment.center,
// }) {
//   FittedSizes fs = applyBoxFit(fit, src, dst.size);
//   double scaleX = fs.destination.width / fs.source.width;
//   double scaleY = fs.destination.height / fs.source.height;
//   Size fittedSrc = Size(src.width * scaleX, src.height * scaleY);
//   Rect out = alignment.inscribe(fittedSrc, dst);

//   return Matrix4.identity()
//     ..translate(out.left, out.top)
//     ..scale(scaleX, scaleY);
// }
