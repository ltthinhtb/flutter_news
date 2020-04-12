import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news/models/user.dart';

class DataBase {
  final String uid;

  User user;

  DataBase({this.uid});

  final databaseReference = Firestore.instance;

  Future userCreate(String name, String surName, String email) async {
    var usersRef = databaseReference.collection("users");
    await usersRef.document(uid).setData({
      "name": name,
      'surName': surName,
      "email": email,
    });
  }

  Future updateAvatar(String url) async {
    var usersRef = databaseReference.collection("users");
    await usersRef.document(uid).updateData({'photoUrl': url});
  }

  Future<User> dataUser() async {
    var usersRef = databaseReference.collection("users");
    DocumentSnapshot doc = await usersRef.document(uid).get();
    user = User.fromDocument(doc);
    return user;
  }
}
