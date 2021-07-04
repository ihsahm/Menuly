import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessServices {
  getBusiness() {
    return FirebaseFirestore.instance.collection("Restaurant").snapshots();
  }
}
