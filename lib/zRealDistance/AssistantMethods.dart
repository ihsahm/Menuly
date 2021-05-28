import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'request_assistant.dart';
import 'directiondetails.dart';

class AssistantMethods {
  static Future<DirectionDetails> obtainDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=AIzaSyB9VkNZsYubmBdcWm-WkOemaRwxKdi_alk";

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == "failed") {
      print(res.toString());
    }
    if (res == null) {
      print(res.toString());
    }
    try {
      DirectionDetails directionDetails = DirectionDetails();

      directionDetails.encodedPoints =
          res["routes"][0]["overview_polyline"]["points"];
      directionDetails.distanceText =
          res["routes"][0]["legs"][0]["distance"]["text"];

      directionDetails.distanceValue =
          res["routes"][0]["legs"][0]["distance"]["value"];

      directionDetails.durationText =
          res["routes"][0]["legs"][0]["duration"]["text"];

      directionDetails.durationValue =
          res["routes"][0]["legs"][0]["duration"]["value"];

      return directionDetails;
    } catch (exp) {
      print(exp.toString());
    }
  }
}
