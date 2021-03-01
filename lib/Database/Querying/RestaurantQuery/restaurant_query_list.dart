import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Querying extends GetxController {
  getAllData() async {
    return FirebaseFirestore.instance.collection('Restaurant').get();
  }

  getVegeterianData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Vegeterian")
        .get();
  }

  getRestaurantData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Restaurant")
        .get();
  }

  getCafeData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Cafe")
        .get();
  }

  getBurgerData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Fast food")
        .get();
  }

  getFastingData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Fasting")
        .get();
  }

  getPastaData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Pasta")
        .get();
  }
}
