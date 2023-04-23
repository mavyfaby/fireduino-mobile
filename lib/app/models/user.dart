class User {
  final int? id;
  final int? eid;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String createdAt;

  User({
    required this.id,
    required this.eid,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['a'],
      eid: json['b'],
      username: json['c'],
      firstName: json['d'],
      lastName: json['e'],
      email: json['f'],
      createdAt: json['g'],
    );
  }

  Map<String, dynamic> toJson() => {
    'a': id,
    'b': eid,
    'c': username,
    'd': firstName,
    'e': lastName,
    'f': email,
    'g': createdAt,
  };

  /// Get fullname
  String getFullname() {
    return "$firstName $lastName";
  }

  /// Get email
  String getEmail() {
    return email;
  }
}