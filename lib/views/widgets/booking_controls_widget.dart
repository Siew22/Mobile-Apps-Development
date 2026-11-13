import 'package:flutter/material.dart';
import '../../viewmodels/cruise_booking_viewmodel.dart';

class BookingControlsWidget extends StatelessWidget {
  final CruiseBookingViewModel viewModel;

  const BookingControlsWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        "${viewModel.selectedDate.day.toString().padLeft(2, '0')}/"
        "${viewModel.selectedDate.month.toString().padLeft(2, '0')}/"
        "${viewModel.selectedDate.year}";

    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Controls & Booking',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),

            // 1. Visit Date Picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_month),
              title: const Text('Visit Date:'),
              subtitle: Text(
                formattedDate,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                child: const Text('Select Date'),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: viewModel.selectedDate,
                    firstDate: DateTime(2025),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    viewModel.setBookingDate(picked);
                  }
                },
              ),
            ),
            const SizedBox(height: 8),

            // 2. Cruise's Package Selection (Dropdown)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.directions_boat_outlined),
                    SizedBox(width: 12),
                    Text('Package:', style: TextStyle(fontSize: 15)),
                  ],
                ),
                DropdownButton<String>(
                  value: viewModel.selectedPackage,
                  items: viewModel.packages.map((String pkg) {
                    return DropdownMenuItem<String>(
                      value: pkg,
                      child: Text(pkg),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      viewModel.setPackage(newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 3. Dark Mode Theme Toggle
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: Icon(
                viewModel.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              title: const Text('Dark Mode Theme'),
              value: viewModel.isDarkMode,
              onChanged: (bool value) => viewModel.toggleTheme(value),
            ),
          ],
        ),
      ),
    );
  }
}