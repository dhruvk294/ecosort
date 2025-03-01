import 'package:flutter/material.dart';

class WasteManagementInfoPage extends StatelessWidget {
  const WasteManagementInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildContentPage([
      _buildInfoCard(
        'What is Waste Management?',
        'Waste management involves the collection, transport, processing, recycling, or disposal of waste materials. It helps reduce the impact of waste on the environment and human health. Effective waste management practices ensure that waste is handled efficiently from its inception to its final disposal, covering various stages including collection, sorting, and recycling.',
      ),
      _buildInfoCard(
        'Why is it Important?',
        'Proper waste management reduces pollution, conserves natural resources, and ensures that waste is handled in an environmentally friendly manner. It helps maintain the balance of the ecosystem and protects wildlife. By managing waste effectively, we can prevent harmful chemicals from leaching into the soil and waterways, thereby safeguarding the health of both humans and the environment.',
      ),
      _buildInfoCard(
        'Types of Waste',
        '1. Organic Waste: Includes kitchen waste, vegetables, flowers, leaves, and fruits. This waste is biodegradable and can be composted.\n\n'
            '2. Inorganic Waste: Includes materials like plastic, glass, and metals that do not decompose easily. These materials can often be recycled to reduce their impact on the environment.\n\n'
            '3. Hazardous Waste: Includes waste that poses a threat to public health or the environment, such as chemicals, batteries, and pesticides. These require special disposal methods to prevent harm.\n\n'
            '4. E-waste: Consists of discarded electronic appliances like computers, TVs, and mobile phones. E-waste contains valuable materials that can be recovered, but it also contains hazardous substances that must be handled carefully.',
      ),
      _buildInfoCard(
        'How Can You Contribute?',
        '1. Separate Waste: Divide your waste into recyclables, compostables, and general waste. Use different bins to ensure proper disposal.\n\n'
            '2. Reduce, Reuse, Recycle: Adopt a minimalistic lifestyle by reducing the amount of waste you generate. Reuse items where possible, and always recycle to minimize your environmental footprint.\n\n'
            '3. Composting: Compost organic waste to create nutrient-rich soil for your garden. Composting not only reduces waste but also improves soil quality.\n\n'
            '4. Proper Disposal: Dispose of hazardous waste like batteries and chemicals at designated collection points. Avoid mixing hazardous materials with general waste.\n\n'
            '5. Support Local Initiatives: Participate in or support local community cleanup efforts and waste management programs. By getting involved, you can help make a difference in your community’s approach to waste management.',
      ),
      _buildInfoCard(
        'The Role of Technology in Waste Management',
        '1. Smart Bins: These bins are equipped with sensors that monitor the fill level and send notifications when they need to be emptied, optimizing waste collection routes and reducing operational costs.\n\n'
            '2. Waste-to-Energy Technologies: Modern technologies allow the conversion of waste materials into energy, reducing the reliance on fossil fuels and minimizing landfill use.\n\n'
            '3. Recycling Innovations: Advances in technology have led to better sorting methods and recycling processes, making it possible to recycle more types of materials efficiently.\n\n'
            '4. AI and Machine Learning: AI algorithms are being used to optimize waste sorting and processing, predicting waste generation patterns, and enhancing recycling efficiency.\n\n'
            '5. Blockchain for Waste Management: Blockchain technology ensures transparency and traceability in the waste management supply chain, making sure that waste is managed responsibly.',
      ),
      _buildInfoCard(
        'Challenges in Waste Management',
        '1. Lack of Awareness: Many people are still unaware of the importance of waste management and how to separate their waste properly.\n\n'
            '2. Infrastructure Issues: Inadequate waste collection and processing infrastructure can lead to inefficient waste management practices.\n\n'
            '3. Cost: The cost of setting up and maintaining effective waste management systems can be high, especially for developing regions.\n\n'
            '4. Illegal Dumping: Illegal dumping of waste poses a serious threat to the environment and public health. Strict regulations and enforcement are needed to prevent this.\n\n'
            '5. Changing Consumption Patterns: The increasing use of single-use plastics and the growing volume of e-waste present new challenges for waste management systems.',
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
                fontSize: 20.0,
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
