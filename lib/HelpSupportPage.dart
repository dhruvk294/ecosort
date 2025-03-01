import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[50]!, Colors.lightGreen[100]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Removed title, as it's handled by AppBar now.
            const SizedBox(height: 20.0), // Adding some space at the top
            _buildInfoCard(
              '1. FAQs',
              'Find answers to the most frequently asked questions. Explore common queries and solutions related to our services.',
              onTap: () {
                // Navigate to FAQs page or show a dialog with FAQs
              },
            ),
            _buildInfoCard(
              '2. Contact Us',
              'Get in touch with our support team for personalized assistance. We are here to help you with any issues or concerns.',
              onTap: () {
                // Navigate to contact form or show contact details
              },
            ),
            _buildInfoCard(
              '3. Troubleshooting',
              'Follow these troubleshooting steps to resolve common problems. Learn how to fix issues and get back on track quickly.',
              onTap: () {
                // Navigate to troubleshooting guide or show a dialog
              },
            ),
            _buildInfoCard(
              '4. Submit Feedback',
              'Share your feedback or suggestions to help us improve our services. We value your input and strive to enhance your experience.',
              onTap: () {
                // Navigate to feedback form or show feedback options
              },
            ),
            _buildInfoCard(
              '5. User Guide',
              'Access our comprehensive user guide to understand the features and functionality of our app. A step-by-step manual for all users.',
              onTap: () {
                // Navigate to user guide page or show a dialog
              },
            ),
            _buildInfoCard(
              '6. Privacy Policy',
              'Read our privacy policy to understand how we handle your data and protect your information. Transparency is our priority.',
              onTap: () {
                // Navigate to privacy policy page or show a dialog
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String description,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
