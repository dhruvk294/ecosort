class Complaint {
  final String id;
  final String userId;
  final String userEmail;
  final String location;
  final String description;
  final String imageUrl;
  final DateTime dateSubmitted;
  final String status; // 'pending', 'in_progress', 'resolved'
  final String? adminResponse;

  Complaint({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.dateSubmitted,
    this.status = 'pending',
    this.adminResponse,
  });

  // Create a copy of the complaint with updated fields
  Complaint copyWith({
    String? id,
    String? userId,
    String? userEmail,
    String? location,
    String? description,
    String? imageUrl,
    DateTime? dateSubmitted,
    String? status,
    String? adminResponse,
  }) {
    return Complaint(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
      location: location ?? this.location,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      dateSubmitted: dateSubmitted ?? this.dateSubmitted,
      status: status ?? this.status,
      adminResponse: adminResponse ?? this.adminResponse,
    );
  }

  // Convert complaint to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userEmail': userEmail,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'dateSubmitted': dateSubmitted.toIso8601String(),
      'status': status,
      'adminResponse': adminResponse,
    };
  }

  // Create complaint from map
  factory Complaint.fromMap(Map<String, dynamic> map) {
    return Complaint(
      id: map['id'],
      userId: map['userId'],
      userEmail: map['userEmail'],
      location: map['location'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      dateSubmitted: DateTime.parse(map['dateSubmitted']),
      status: map['status'],
      adminResponse: map['adminResponse'],
    );
  }
}
