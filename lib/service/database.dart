import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_news/models/response/user.dart';

class DataBase {
  final String uid;

  User user;

  DataBase({this.uid});

  final databaseReference = Firestore.instance;

  final FirebaseMessaging _fcm = FirebaseMessaging();

  void getToken() {
    _fcm.requestNotificationPermissions();

    _fcm.getToken().then((token) {
      print('token: $token');
      Firestore.instance
          .collection('users')
          .document(uid)
          .updateData({'pushToken': token});
    }).catchError((err) {
      print('error');
    });
  }

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

  Future saveRecentNews(
      {String title, String photo, String url, int id}) async {
    var usersRef = databaseReference.collection("users");
    usersRef.document(uid).get().then((snapShot) async {
      await usersRef.document(uid).updateData({
        "recent_news": FieldValue.arrayUnion([
          {"title": title, "photo": photo, "url": url, "id": id}
        ])
      });
    });
  }

  Future saveLoveNews({String title, String photo, String url, int id}) async {
    var usersRef = databaseReference.collection("users");
    usersRef.document(uid).get().then((snapShot) async {
      await usersRef.document(uid).updateData({
        "love_news": FieldValue.arrayUnion([
          {
            "love_title": title,
            "love_photo": photo,
            "love_url": url,
            "love_id": id
          }
        ])
      });
    });
  }

  Future saveComment(
      {String userName,
      String userId,
      String url,
      String comment,
      Timestamp timestamp,
      String id}) async {
    var usersRef = databaseReference.collection("post");
    usersRef.document(id).get().then((snapShot) async {
      if (snapShot == null || !snapShot.exists) {
        await usersRef.document(id).setData({
          "comment": FieldValue.arrayUnion([
            {
              "userName": userName,
              "comment_title": comment,
              "userId": userId,
              "timestamp": timestamp,
              'url': url ?? "thinh",
            }
          ])
        });
      } else
        await usersRef.document(id).updateData({
          "comment": FieldValue.arrayUnion([
            {
              "userName": userName,
              "comment_title": comment,
              "userId": userId,
              "timestamp": timestamp,
              'url': url,
            }
          ])
        });
    });
  }

  Future deleteComment(
      {
        String id,
      String idComment}) async {
    var usersRef = databaseReference.collection("post");
    usersRef.document(id).collection('comment').document(idComment).delete();
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

  Future userNotification(
      String title, String photo, String url, String id) async {
    var usersRef = databaseReference.collection("notification");
    usersRef.document(uid).get().then((snapShot) async {
      await usersRef
          .document(uid)
          .setData({"title": title, 'photo': photo, "url": url, "id": id});
    });
  }

  Future deleteLoveNews(
      {String title, String photo, String url, int id}) async {
    var usersRef = databaseReference.collection("users");
    usersRef.document(uid).get().then((snapShot) async {
      await usersRef.document(uid).updateData({
        "recent_news": FieldValue.arrayRemove([
          {
            "love_title": title,
            "love_photo": photo,
            "love_url": url,
            "love_id": id
          }
        ])
      });
    });
  }
}
