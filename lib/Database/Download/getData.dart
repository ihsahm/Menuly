import 'package:cloud_firestore/cloud_firestore.dart';

class GetData {
  getTicketData() async {
    return FirebaseFirestore.instance.collection('Tickets').snapshots();
  }

  getRestaurantData() async {
    return FirebaseFirestore.instance.collection('Restaurant').snapshots();
  }

  getCafeData() async {
    return FirebaseFirestore.instance.collection('Cafes').snapshots();
  }

  getHotelData() async {
    return FirebaseFirestore.instance.collection('Hotels').snapshots();
  }

  getEntertainmentData() async {
    return FirebaseFirestore.instance.collection('Entertainment').snapshots();
  }

  getShoppingData() async {
    return FirebaseFirestore.instance.collection('Shopping').snapshots();
  }

  getMenuData() async {
    return FirebaseFirestore.instance.collection('Restaurant/Menu').snapshots();
  }
}
