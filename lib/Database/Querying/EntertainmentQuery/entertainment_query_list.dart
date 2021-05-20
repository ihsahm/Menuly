import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EntertainmentQuery extends GetxController {
  getAllData() async {
    return FirebaseFirestore.instance.collection('Entertainment').get();
  }

  getGameZoneData() async {
    return FirebaseFirestore.instance
        .collection('Entertainment')
        .where("type", isEqualTo: "Gamezones")
        .get();
  }

  getCinemaData() async {
    return FirebaseFirestore.instance
        .collection('Entertainment')
        .where("type", isEqualTo: "Cinema")
        .get();
  }

  getTheaterData() async {
    return FirebaseFirestore.instance
        .collection('Entertainment')
        .where("type", isEqualTo: "Theater")
        .get();
  }

  getParksData() async {
    return FirebaseFirestore.instance
        .collection('Entertainment')
        .where("type", isEqualTo: "Parks")
        .get();
  }
}
