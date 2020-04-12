import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String photoUrl;
  final String surName;
  final String bio;

  User({
    this.name,
    this.email,
    this.photoUrl,
    this.surName,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      email: doc['email'],
      name: doc['name'],
      photoUrl: doc['photoUrl'],
      surName: doc['surName'],
      bio: doc['bio'],
    );
  }
}
