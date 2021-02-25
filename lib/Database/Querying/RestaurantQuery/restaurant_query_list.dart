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

  getBurgerData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Fast food")
        .get();
  }

  getComboData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Combo")
        .get();
  }

  getInjeraData() async {
    return FirebaseFirestore.instance
        .collection('Restaurant')
        .where("type", isEqualTo: "Injera")
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
