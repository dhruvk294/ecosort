import 'package:flutter/material.dart';
import 'NgoDrive.dart';

class NGODrivesPage extends StatefulWidget {
  const NGODrivesPage({super.key});

  @override
  _NGODrivesPageState createState() => _NGODrivesPageState();
}

class _NGODrivesPageState extends State<NGODrivesPage> {
  List<NGODrive> _drives = [];

  @override
  void initState() {
    super.initState();
    _loadDrives();
  }

  void _loadDrives() {
    // Simulated data loading
    setState(() {
      _drives = [
        NGODrive(
          title: 'Beach Cleanup',
          description: 'Join us to clean up the beach.',
          date: DateTime(2024, 9, 20),
          location: 'Santa Monica Beach',
          rewardPoints: 50,
        ),
        NGODrive(
          title: 'Tree Planting',
          description: 'Help us plant trees in the local park.',
          date: DateTime(2024, 10, 5),
          location: 'Central Park',
          rewardPoints: 70,
        ),
        NGODrive(
          title: 'Recycling Workshop',
          description: 'Learn how to recycle effectively.',
          date: DateTime(2024, 11, 10),
          location: 'Community Center',
          rewardPoints: 30,
        ),
      ];
    });
  }

  void _toggleParticipation(NGODrive drive) {
    setState(() {
      drive.isParticipating = !drive.isParticipating;
    });
    // Implement backend update if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _drives.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _drives.length,
              itemBuilder: (context, index) {
                final drive = _drives[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color:
                      Theme.of(context).cardColor, // Match card color to theme
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                drive.title,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700], // Theme color
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10), // Add some spacing
                            Chip(
                              label: Text(
                                '${drive.rewardPoints} Points',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.green[500], // Theme color
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          drive.description,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.color, // Use theme text color
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Date: ${drive.date.toLocal().toString().split(' ')[0]}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.color, // Theme text color
                          ),
                        ),
                        Text(
                          'Location: ${drive.location}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.color, // Theme text color
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () => _toggleParticipation(drive),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: drive.isParticipating
                                ? Colors.grey
                                : Colors.green[700], // Theme color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                          ),
                          child: Text(
                            drive.isParticipating
                                ? 'Participating'
                                : 'Participate',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
