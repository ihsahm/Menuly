import 'package:e_commerce/zRealDistance/AssistantMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider with ChangeNotifier {
  var locationMessage = "";
  var passlat;
  var passlong;
  bool permissionAllowed = false;

  @override
  Future<String> getCurrentLocation(String slatitude, String slongitude) async {
    var slat = double.parse(slatitude);
    var slon = double.parse(slongitude);
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    passlat = position.latitude;
    passlong = position.longitude;

    LatLng a = LatLng(passlat, passlong);
    LatLng b = LatLng(slat, slon);

    var details = await AssistantMethods.obtainDirectionDetails(a, b);

    // List<int> disList = [];
    // disList.add(details.distanceValue);
    // print(disList.quickSort());
    // this.permissionAllowed = true;

    return details.distanceValue.toString();
  }
}

// ignore: missing_return
// Future<String> jsonResponse.sort((a, b) {
//   var distance1 = new GreatCircleDistance.fromDegrees(latitude1: double.parse(widget.lat), longitude1: double.parse(widget.lng), latitude2: double.parse(a.lat), longitude2: double.parse(a.lng));
//   var totaldistance1 = distance1.haversineDistance().toStringAsFixed(2);
//   double distanceDouble1 = double.parse (totaldistance1);
//   var distance2 = new GreatCircleDistance.fromDegrees(latitude1: double.parse(widget.lat), longitude1: double.parse(widget.lng), latitude2: double.parse(b.lat), longitude2: double.parse(b.lng));
//   var totaldistance2 = distance2.haversineDistance().toStringAsFixed(2);
//   double distanceDouble2 = double.parse(totaldistance2);
//   return (distanceDouble1 - distanceDouble2).toInt();
// });

// _foodByCategories.sort((a, b) {
//       var distance1 = new GreatCircleDistance.fromDegrees(
//           latitude1:
//               model.userLocation == null ? 0.0 : model.userLocation["latitude"],
//           longitude1: model.userLocation == null
//               ? 0.0
//               : model.userLocation["longitude"],
//           latitude2: a.lat,
//           longitude2: a.long);
//       double totaldistance1 = distance1.haversineDistance();

//       var distance2 = new GreatCircleDistance.fromDegrees(
//           latitude1:
//               model.userLocation == null ? 0.0 : model.userLocation["latitude"],
//           longitude1: model.userLocation == null
//               ? 0.0
//               : model.userLocation["longitude"],
//           latitude2: b.lat,
//           longitude2: b.long);
//       double totaldistance2 = distance2.haversineDistance();
//       return (totaldistance1 - totaldistance2).toInt();
//     });
