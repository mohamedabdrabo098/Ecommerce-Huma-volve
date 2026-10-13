class UserEntity {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String role;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.role = 'customer',
  });
}

