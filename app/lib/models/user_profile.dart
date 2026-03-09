class UserProfile {
  final String uid;
  final String email;
  final String displayName;
  final bool locationNotifications;

  const UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    this.locationNotifications = false,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      uid: map['uid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      locationNotifications: map['locationNotifications'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'locationNotifications': locationNotifications,
    };
  }
}
