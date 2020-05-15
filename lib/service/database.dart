import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news/models/response/user.dart';


class DataBase {
  final String uid;

  User user;

  DataBase({this.uid});

  final databaseReference = Firestore.instance;

  Future userCreate(String name, String surName, String email) async {
    var usersRef = databaseReference.collection("users");
    usersRef.document(uid).get().then((snapShot) async {
      if (snapShot == null || !snapShot.exists) {
        await usersRef.document(uid).setData({
          "name": name,
          'surName': surName,
          "email": email,
        });
      }
    });
  }

  Future saveRecentNews({String title, String photo, String url,int id}) async {
    var usersRef = databaseReference.collection("users");
    usersRef.document(uid).get().then((snapShot) async {
        await usersRef.document(uid).updateData({
          "recent_news" : FieldValue.arrayUnion([{
            "title" : title,
            "photo" : photo,
            "url" : url,
            "id" : id
          }])
        });
    });
  }

  Future saveLoveNews({String title, String photo, String url,int id}) async {
    var usersRef = databaseReference.collection("users");
    usersRef.document(uid).get().then((snapShot) async {
      await usersRef.document(uid).updateData({
        "love_news" : FieldValue.arrayUnion([{
          "love_title" : title,
          "love_photo" : photo,
          "love_url" : url,
          "love_id" : id
        }])
      });
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
