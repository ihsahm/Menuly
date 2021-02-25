import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CafeQuerying extends GetxController {
  getAllData() async {
    return FirebaseFirestore.instance.collection('Cafes').get();
  }

  getCakeData() async {
    return FirebaseFirestore.instance
        .collection('Cafes')
        .where("type", isEqualTo: "Cake")
        .get();
  }

  getCoffeeData() async {
    return FirebaseFirestore.instance
        .collection('Cafes')
        .where("type", isEqualTo: "Coffee")
        .get();
  }

  getIceCreamData() async {
    return FirebaseFirestore.instance
        .collection('Cafes')
        .where("type", isEqualTo: "IceCream")
        .get();
  }

  getJuiceData() async {
    return FirebaseFirestore.instance
        .collection('Cafes')
        .where("type", isEqualTo: "Juice")
        .get();
  }
}
