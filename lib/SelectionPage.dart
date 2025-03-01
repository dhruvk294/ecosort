import 'package:flutter/material.dart';
import 'WasteManagementInfoPage.dart';
import 'RaiseComplaintPage.dart';
import 'RecyclingTipsPage.dart';
import 'WasteSegregationPage.dart';
import 'NGODrivePage.dart';

class SelectionPage extends StatelessWidget {
  final Function(Widget, String) onPageSelected;

  const SelectionPage({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      mainAxisSpacing: 16.0,
      crossAxisSpacing: 16.0,
      children: [
        _buildPageBox(Icons.camera_alt, 'Waste Segregation',
            WasteSegregationPage(), context),
        _buildPageBox(Icons.report_problem, 'Raise Complaint',
            RaiseComplaintPage(), context),
        _buildPageBox(Icons.info, 'Waste Management Info',
            WasteManagementInfoPage(), context),
        _buildPageBox(
            Icons.recycling, 'Recycling Tips', RecyclingTipsPage(), context),
        _buildPageBox(
          Icons.volunteer_activism,
          'NGO Drives',
          NGODrivesPage(),
          context,
        ),
      ],
    );
  }

  Widget _buildPageBox(
      IconData icon, String title, Widget page, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPageSelected(
            page, title); // Use the callback to navigate and set the title
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50.0, color: Colors.green[700]),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }
}
