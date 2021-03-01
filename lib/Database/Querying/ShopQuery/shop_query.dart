import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ShopQuery extends GetxController {
  getAllData() async {
    return FirebaseFirestore.instance.collection('Shopping').get();
  }

  getSuperMarket() async {
    return FirebaseFirestore.instance
        .collection('Shopping')
        .where('type', isEqualTo: 'Supermarket')
        .get();
  }

  getMiniMarket() async {
    return FirebaseFirestore.instance
        .collection('Shopping')
        .where('type', isEqualTo: 'Minimarket')
        .get();
  }

  getMarket() async {
    return FirebaseFirestore.instance
        .collection('Shopping')
        .where('type', isEqualTo: 'Market')
        .get();
  }
}
