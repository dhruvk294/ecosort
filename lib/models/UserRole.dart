enum UserRole { admin, user }

class User {
  final String name;
  final String email;
  final String location;
  final String joinDate;
  final UserRole role;
  final int totalPoints;
  final int wastePhotosSubmitted;
  final int ngoDriveParticipations;
  final String profileImage;

  User({
    required this.name,
    required this.email,
    required this.location,
    required this.joinDate,
    required this.role,
    this.totalPoints = 0,
    this.wastePhotosSubmitted = 0,
    this.ngoDriveParticipations = 0,
    this.profileImage = '',
  });

  // Check if user is admin
  bool get isAdmin => role == UserRole.admin;

  // In a real app, this would be stored in a secure database
  static List<String> adminEmails = [
    'admin@ecosort.com',
    'moderator@ecosort.com'
  ];

  // Add new admin
  static bool addAdmin(String email) {
    if (!adminEmails.contains(email)) {
      adminEmails.add(email);
      return true;
    }
    return false;
  }

  // Remove admin
  static bool removeAdmin(String email) {
    if (email != 'admin@ecosort.com') {
      // Prevent removing super admin
      return adminEmails.remove(email);
    }
    return false;
  }

  // Factory method to create user with appropriate role
  factory User.fromEmail({
    required String name,
    required String email,
    required String location,
    required String joinDate,
  }) {
    return User(
      name: name,
      email: email,
      location: location,
      joinDate: joinDate,
      role: adminEmails.contains(email) ? UserRole.admin : UserRole.user,
    );
  }

  // Convert user to admin
  User toAdmin() {
    return User(
      name: name,
      email: email,
      location: location,
      joinDate: joinDate,
      role: UserRole.admin,
      totalPoints: totalPoints,
      wastePhotosSubmitted: wastePhotosSubmitted,
      ngoDriveParticipations: ngoDriveParticipations,
      profileImage: profileImage,
    );
  }

  // Convert admin to regular user
  User toUser() {
    return User(
      name: name,
      email: email,
      location: location,
      joinDate: joinDate,
      role: UserRole.user,
      totalPoints: totalPoints,
      wastePhotosSubmitted: wastePhotosSubmitted,
      ngoDriveParticipations: ngoDriveParticipations,
      profileImage: profileImage,
    );
  }
}
