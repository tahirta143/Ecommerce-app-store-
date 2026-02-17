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

  // ✅ Fixed: API returns '_id' (MongoDB), fallback to 'id' for safety
  factory User.fromNonAdminJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      provider: json['provider'] ?? 'local',
      role: UserRole.user,
    );
  }

  // ✅ Fixed: API returns '_id' (MongoDB), fallback to 'id' for safety
  factory User.fromAdminJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: UserRole.admin,
    );
  }

  // toJson uses 'id' (no underscore) — consistent with fromJson below
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'provider': provider,
      'role': role.index, // 0=admin, 1=user, 2=guest
    };
  }

  // fromJson reads 'id' (no underscore) since toJson wrote it that way
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      provider: json['provider'],
      role: UserRole.values[json['role'] ?? 1],
    );
  }
}