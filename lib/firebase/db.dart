import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'authentication.dart';
import 'package:intl/intl.dart';

String collectionName = 'wastedFood';

Future<Map<String, dynamic>> getUserInfo() async {
  Map<String, dynamic> data = {};
  String uid = AuthenticationHelper().uid;
  await FirebaseFirestore.instance.collection(collectionName).doc(uid).get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists){
      data = documentSnapshot.data() as Map<String, dynamic>;
    }else{
      print("document doesn't exist");
    };
  });
  return data;
}

Future<bool> editUserInfo(Map<String, dynamic> data) async {
  String uid = AuthenticationHelper().uid;
  FirebaseFirestore.instance.collection(collectionName).doc(uid).set(data);
  return true;
}

Future<Map> getVote() async {
  Map<String, dynamic> data = {};
  await FirebaseFirestore.instance.collection(collectionName).doc('vote').get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists){
      data = documentSnapshot.data() as Map<String, dynamic>;
    }else{
      print("document doesn't exist");
    }
    print("data:$data");
  });
  return data;

}

Future<bool> addVote(Map<String, dynamic> data) async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  FirebaseFirestore.instance.collection(collectionName).doc('vote').set({formatted: data});
  return true;
}

Future<Map> getFood() async {
  Map<String, dynamic> data = {};
  await FirebaseFirestore.instance.collection(collectionName).doc('food').get().then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists){
      data = documentSnapshot.data() as Map<String, dynamic>;
    }else{
      print("document doesn't exist");
    }
  });
  return data;
}

Future<bool> addFood(Map<String, dynamic> data) async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  FirebaseFirestore.instance.collection(collectionName).doc('food').set({formatted: data});
  return true;
}

Future<bool> userVote(Map<String, dynamic> data) async {

  FirebaseFirestore.instance.collection(collectionName).doc('vote').update(data);
  return true;
}

UploadTask? uploadFile(String destination, File file) {
  try {
    final ref = FirebaseStorage.instance.ref(destination);
    return ref.putFile(file);
  } on FirebaseException catch (e) {
    print('===== error ========');
    print(e);
    return null;
  }
}
