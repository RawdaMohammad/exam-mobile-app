import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  String? message;
  String? token;
  User? user;

  UserResponse({this.message, this.token, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    message: json["message"],
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? rePassword;
  String? phone;
  bool? isVerified;
  String? id;

  User({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
    this.isVerified,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    rePassword: json["rePassword"],
    phone: json["phone"],
    isVerified: json["isVerified"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password":password,
    "rePassword":rePassword,
    "phone": phone,
    "isVerified": isVerified,
    "_id": id,
  };
}
