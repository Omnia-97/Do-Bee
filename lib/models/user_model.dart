class UserModel {
  String id;
  String fullName;
  static const String collectionName = 'Users';
  String email;
  bool emailVerified;

  UserModel({
    required this.id,
    this.emailVerified = false,
    required this.email,
    this.fullName = '',
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          fullName: json['fullName'],
          emailVerified: json['emailVerified'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'emailVerified': emailVerified,
    };
  }
}
