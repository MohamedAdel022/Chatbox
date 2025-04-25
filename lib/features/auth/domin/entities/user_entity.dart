class UserEntity {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String bio;
  final DateTime createdAt;
  final DateTime lastActive;
  final bool isOnline;
  final String pushToken;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.bio,
    required this.createdAt,
    required this.lastActive,
    required this.isOnline,
    required this.pushToken,
  });

  toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'bio': bio,
      'createdAt': createdAt,
      'lastActive': lastActive,
      'isOnline': isOnline,
      'pushToken': pushToken,
    };
  }
}
