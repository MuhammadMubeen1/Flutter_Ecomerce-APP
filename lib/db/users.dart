import 'package:ecomerceprojecr/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class UserServices{
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";
  User? user = FirebaseAuth.instance.currentUser;
  createUser(Map value, ){
    _database.ref(ref).child(user!.uid).set(value);
  }
}