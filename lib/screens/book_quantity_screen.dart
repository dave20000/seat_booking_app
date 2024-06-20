import 'package:flutter/material.dart';
import 'package:seat_booking_app/widgets/custom_text_form_field.dart';

import '../widgets/custom_app_bar.dart';
import 'seat_selection_screen.dart';

class BookingQuantityScreen extends StatefulWidget {
  const BookingQuantityScreen({super.key});

  @override
  State<BookingQuantityScreen> createState() => _BookingQuantityScreenState();
}

class _BookingQuantityScreenState extends State<BookingQuantityScreen> {
  late final TextEditingController _quantityController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _quantityController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Booking Quantity',
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Booking Seat Quantity",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                CustomTextFormField(
                  controller: _quantityController,
                  labelText: 'Number of Tickets',
                  keyboardType: TextInputType.number,
                  errorText: 'Please enter number of tickets',
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeatSelectionScreen(
                            quantity: int.parse(_quantityController.text),
                          ),
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
