import 'package:flutter/material.dart';

class RecyclingTipsPage extends StatelessWidget {
  const RecyclingTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildContentPage([
      _buildInfoCard(
        'Understand Your Local Recycling Guidelines',
        'Different areas have different rules for what can and cannot be recycled. Make sure to familiarize yourself with your local guidelines to avoid contamination.',
      ),
      _buildInfoCard(
        'Clean and Dry Your Recyclables',
        'Ensure that items such as bottles and cans are clean and dry before placing them in the recycling bin. Contaminants can spoil the entire batch of recyclables.',
      ),
      _buildInfoCard(
        'Separate Materials',
        'Separate recyclables into different categories, such as paper, plastics, and metals. This helps in easier processing and increases the efficiency of recycling facilities.',
      ),
      _buildInfoCard(
        'Reduce and Reuse',
        'Before recycling, consider if items can be reused or repurposed. Reducing the amount of waste you generate is even better than recycling.',
      ),
      _buildInfoCard(
        'Recycle Electronics Properly',
        'Electronics contain hazardous materials and should be recycled separately. Look for local e-waste recycling programs or events.',
      ),
      _buildInfoCard(
        'Avoid Plastic Bags in Recycling',
        'Plastic bags can tangle in machinery and are often not recyclable through curbside programs. Use reusable bags or dispose of plastic bags at designated collection points.',
      ),
      _buildInfoCard(
        'Check for Recycling Symbols',
        'Look for the recycling symbol on products and packaging. The number inside the symbol can help determine if the item is recyclable in your area.',
      ),
      _buildInfoCard(
        'Avoid Wishcycling',
        'Wishcycling is the practice of putting non-recyclable items in the recycling bin, hoping they will be recycled. This can cause contamination and disrupt recycling processes.',
      ),
      _buildInfoCard(
        'Buy Recycled Products',
        'Support the recycling industry by purchasing products made from recycled materials. This helps create a demand for recyclable materials.',
      ),
    ]);
  }

  Widget _buildContentPage(List<Widget> content) {
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
            const SizedBox(height: 20.0),
            ...content,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String description) {
    return Card(
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
    );
  }
}
