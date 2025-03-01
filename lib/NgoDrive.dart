class NGODrive {
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final num rewardPoints;
  bool isParticipating;

  NGODrive({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.rewardPoints,
    this.isParticipating = false,
  });
}
