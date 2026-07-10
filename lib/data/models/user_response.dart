import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? role;
  bool? isVerified;
  String? id;

  UserResponse({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.isVerified,
    this.id,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    role: json["role"],
    isVerified: json["isVerified"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "role": role,
    "isVerified": isVerified,
    "_id": id,
  };
}
