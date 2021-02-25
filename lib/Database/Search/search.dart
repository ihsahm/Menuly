import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Search extends GetxController {
  Future queryRestaurantData(String queryString) async {
    return FirebaseFirestore.instance
        .collection("Restaurant")
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  Future queryCafeData(String queryString) async {
    return FirebaseFirestore.instance
        .collection("Cafes")
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  Future queryHotelData(String queryString) async {
    return FirebaseFirestore.instance
        .collection("Hotels")
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
