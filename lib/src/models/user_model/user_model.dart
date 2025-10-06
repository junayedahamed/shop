class UserModel {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;
  final String userid;
  // final String refreshtoken;
  final String? location;
  final String? profileImage; // New nullable field

  const UserModel({
    this.profileImage,
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.userid,
    // required this.refreshtoken,
    this.location,
  });

  /// ✅ Create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] is String ? int.parse(json['id']) : json['id'],
    profileImage: json['profile_image'], // safe nullable assignment
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    createdAt: DateTime.parse(json['created_at']),
    userid: json['userid'] ?? '',
    // refreshtoken: json['refreshtoken'] ?? '',
    location: json['location'], // safe nullable assignment
  );

  /// ✅ Convert UserModel to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'created_at': createdAt.toIso8601String(),
    'userid': userid,
    // 'refreshtoken': refreshtoken,
    if (profileImage != null) 'profile_image': profileImage,
    if (location != null) 'location': location, // only include if not null
  };
}
