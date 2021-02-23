import 'package:e_commerce/Models/places_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlacesService {
  static final _service = new PlacesService();

  static PlacesService get() {
    return _service;
  }

  final String searchUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=15000&type=restaurant&key=AIzaSyCiPS0HYDQt1gg04J7nGW0kjoyNLz6g_Xc";
  Future<List<Places>> getNearbyPlaces() async {
    var response = await http.get(searchUrl, headers: {
      'Accept': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    });
    var places = <Places>[];

    List data = json.decode(response.body.toString())["results"];
    //var placesData = <Places>[];
    data.forEach((f) => places.add(new Places(
        f["icon"], f["id"], f["name"], f["rating"].toString(), f["vicinity"])));

    return places;
  }
}
