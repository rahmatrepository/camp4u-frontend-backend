class User {
  final int id;
  final String username;
  final String email;
  final String? fullName;
  final String? phoneNumber;
  final String? profilePicture;
  final String? address;
  final String? city;
  final String? province;
  final String? postalCode;
  final DateTime? dateOfBirth;
  final String? gender;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.phoneNumber,
    this.profilePicture,
    this.address,
    this.city,
    this.province,
    this.postalCode,
    this.dateOfBirth,
    this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
      address: json['address'],
      city: json['city'],
      province: json['province'],
      postalCode: json['postal_code'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      gender: json['gender'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
      'address': address,
      'city': city,
      'province': province,
      'postal_code': postalCode,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}