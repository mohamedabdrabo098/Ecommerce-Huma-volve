class SignUpModel {
  final String email;
  final String name;
  final String password;
  final String role;
  final String avatar;

  const SignUpModel({
    required this.email,
    required this.name,
    required this.password,
    required this.role,
    required this.avatar,
  });

  // Convert JSON to SignUpModel
  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }

  // Convert SignUpModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
      'role': role,
      'avatar': avatar,
    };
  }

  // Optional: CopyWith method for immutability
  SignUpModel copyWith({
    String? email,
    String? name,
    String? password,
    String? role,
    String? avatar,
  }) {
    return SignUpModel(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
    );
  }
}