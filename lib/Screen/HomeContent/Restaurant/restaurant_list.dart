import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Consts/loading.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Provider/darkThemeprovider.dart';
import 'package:e_commerce/Services/getdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'RestaurantDetailPage/restaurant_detail_screen.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  Timer timer;
  Stream items;
  GetData crudObj = new GetData();

  BusinessServices _businessServices = BusinessServices();
  double userLatitude = 0;
  double userLongitude = 0;
  var currentLocation;

  LocationPermission permission;

  _getLocation() async {
    // if (permission == LocationPermission.denied) {
    //   Fluttertoast.showToast(msg: 'Please allow location');
    // } else if (permission == LocationPermission.deniedForever) {
    //   Fluttertoast.showToast(msg: 'Please allow location in your settings');
    // } else {
    Position position = await Geolocator.getCurrentPosition();
    // if (!mounted) {
    if (position != null) {
      setState(() {
        userLatitude = position.latitude;
        userLongitude = position.longitude;
      });
    } else {
      return Fluttertoast.showToast(msg: 'Error fetching location');
    }

    //   }

    // }
  }

  _getDistance(location) {
    double distance = Geolocator.distanceBetween(
        userLatitude, userLongitude, location.latitude, location.longitude);
    double distanceInKm = distance / 1000;
    return distanceInKm.toStringAsFixed(2);
  }

  @override
  void initState() {
    crudObj.getRestaurantData().then((results) {
      setState(() {
        items = results;
      });
    });

    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return StreamBuilder(
        stream: _businessServices.getBusiness(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            var doc = snapshot.data.documents;
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: doc.length,
                itemBuilder: (BuildContext context, int index) {
                  if (double.parse(
                          _getDistance(doc[index].data()['location'])) <=
                      5) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RestaurantDetailScreen(
                                        restaurantName:
                                            "${doc[index].data()['name']}",
                                        restaurantMenu: doc[index].documentID,
                                        restaurantImage:
                                            "${doc[index].data()['image']}",
                                        restaurantEmail:
                                            "${doc[index].data()['email']}",
                                        restaurantRating: doc[index]
                                            .data()["rating"]
                                            .toDouble(),
                                        restaurantPhone:
                                            "${doc[index].data()['phone']}",
                                        restaurantType:
                                            "${doc[index].data()['type']}",
                                      )));
                        },
                        child: Card(
                          margin: EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
                            bottom: 5,
                          ),
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(
                                    width: double.infinity,
                                    height: 100,
                                    child: CachedNetworkImage(
                                      imageUrl: doc[index].data()['image'],
                                      fit: BoxFit.cover,
                                    )),
                                ListTile(
                                    subtitle: ListView(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          RatingBarIndicator(
                                            rating: doc[index]
                                                .data()["rating"]
                                                .toDouble(),
                                            itemBuilder: (context, index) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 18.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ]),
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(doc[index].data()['name']),
                                          Text(
                                            "${_getDistance(doc[index].data()['location'])} km",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: themeChange.darkTheme
                                                  ? Colors.white
                                                  : Colors.blueGrey[700],
                                              fontSize: 12.0,
                                            ),
                                          )
                                        ])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return LoadingShow.loadingProgress;
          }
        });
  }
}
