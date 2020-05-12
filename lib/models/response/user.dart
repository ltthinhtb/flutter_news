import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String photoUrl;
  final String surName;


  User({
    this.name,
    this.email,
    this.photoUrl,
    this.surName,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      email: doc['email'],
      name: doc['name'],
      photoUrl: doc['photoUrl'],
      surName: doc['surName'],
    );
  }
}
