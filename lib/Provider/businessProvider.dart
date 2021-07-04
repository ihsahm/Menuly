import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusinessProvider with ChangeNotifier {
  //List <Product> _products=[];
  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection("Restaurant")
        .get()
        .then((QuerySnapshot restaurantSnapshot) {
      restaurantSnapshot.docs.forEach((element) {});
    });
  }
}
