import 'package:cloud_firestore/cloud_firestore.dart';

class Crud {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addData(blogData) {
    return _firestore.collection("Blogs").add(blogData).catchError((e) {
      print(e);
    });
  }
}
