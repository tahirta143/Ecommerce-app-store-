enum UserRole {
  admin,
  user,
  guest,
}

class User {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final String? provider;
  final UserRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.provider,
    this.role = UserRole.user,
  });

  // Factory constructor for non-admin user login response
  factory User.fromNonAdminJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      provider: json['provider'] ?? 'local',
      role: UserRole.user,
    );
  }

  // Factory constructor for admin login response
  factory User.fromAdminJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: UserRole.admin,
    );
  }

  // Convert User to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'provider': provider,
      'role': role.index, // Store enum index instead of string
    };
  }

  // Create User from stored JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      provider: json['provider'],
      role: UserRole.values[json['role'] ?? 1], // Default to user if not found
    );
  }
}