import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? password;
  UserModel({this.id, this.fullName, this.email, this.password});

  toJson() {
    return {"fullName": fullName, "email": email, "password": password};
  }

  // map user fetch from db to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullName: data['fullName'],
        email: data["email"],
        password: data["password"]);
  }
}
