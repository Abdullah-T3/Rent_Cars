// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? username;
    String? password;
    String? userType;
   String? projectId;
    UserModel({
        this.userType,
        this.projectId,
        this.username,
        this.password,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        password: json["password"],
        userType: json["user_type"],
        projectId: json["project_id"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "user_type": userType,
        "project_id": projectId,
    };
}