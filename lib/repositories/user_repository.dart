import 'package:achievers_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  createUser(UserModel userModel) async {
    await _db
        .collection("users")
        .add(userModel.toJson())
        .whenComplete(() => printInfo(info: "User has been created"))
        .catchError((error) {
      print(error);
      printError(info: "Something went wrong !!!");
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  updateUser(UserModel userModel) async {
    await _db.collection("users").doc(userModel.id).update(userModel.toJson());
  }
}
