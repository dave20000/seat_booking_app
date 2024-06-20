import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_booking_app/blocs/seat_layout_cubit.dart';

import '../widgets/custom_text_form_field.dart';
import 'occupied_seat_marking_screen.dart';

class VenueSetupScreen extends StatefulWidget {
  const VenueSetupScreen({super.key});

  @override
  State<VenueSetupScreen> createState() => _VenueSetupScreenState();
}

class _VenueSetupScreenState extends State<VenueSetupScreen> {
  late final TextEditingController _rowsController;
  late final TextEditingController _columnsController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _rowsController = TextEditingController();
    _columnsController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _rowsController.dispose();
    _columnsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(title: 'Seat Booking App'),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Venue Setup",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  controller: _rowsController,
                  labelText: 'Number of Rows',
                  keyboardType: TextInputType.number,
                  errorText: 'Please enter number of rows',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _columnsController,
                  labelText: 'Number of Columns',
                  keyboardType: TextInputType.number,
                  errorText: 'Please enter number of columns',
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SeatLayoutCubit>().updateRowAndColCount(
                            int.parse(_rowsController.text),
                            int.parse(_columnsController.text),
                          );

                      _rowsController.text = "";
                      _columnsController.text = "";

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const OccupiedSeatMarkingScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
