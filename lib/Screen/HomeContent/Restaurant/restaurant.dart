import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Consts/colors.dart';
import 'package:e_commerce/Database/Querying/RestaurantQuery/restaurant_query_list.dart';
import 'package:e_commerce/Provider/darkThemeprovider.dart';
import 'package:e_commerce/Screen/HomeContent/Restaurant/restaurant_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';

import 'RestaurantDetailPage/restaurant_detail_screen.dart';

class RestaurantMenu extends StatefulWidget {
  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  final TextEditingController searchController = new TextEditingController();

  final ScrollController controller = new ScrollController();
  QuerySnapshot snapshotData;
  bool isExecuted = false;

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
      return null;
    }

    //   }

    // }
  }

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  _getDistance(location) {
    double distance = Geolocator.distanceBetween(
        userLatitude, userLongitude, location.latitude, location.longitude);
    double distanceInKm = distance / 1000;
    return distanceInKm.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      final themeChange = Provider.of<DarkThemeProvider>(context);
      return ListView.builder(
          controller: controller,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index) {
            if (double.parse(_getDistance(
                    snapshotData.docs[index].data()['location'])) <=
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
                                      "${snapshotData.docs[index].data()['name']}",
                                  restaurantMenu: snapshotData.docs[index].id,
                                  restaurantImage:
                                      "${snapshotData.docs[index].data()['image']}",
                                  restaurantEmail:
                                      "${snapshotData.docs[index].data()['email']}",
                                  restaurantInstagram:
                                      "${snapshotData.docs[index].data()['instagram']}",
                                  restaurantFacebook:
                                      "${snapshotData.docs[index].data()['facebook']}",
                                  restaurantPhone:
                                      "${snapshotData.docs[index].data()['phone']}",
                                  restaurantType:
                                      "${snapshotData.docs[index].data()['type']}",
                                  restaurantRating: snapshotData.docs[index]
                                      .data()["rating"]
                                      .toDouble(),
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
                                imageUrl:
                                    snapshotData.docs[index].data()['image'],
                                fit: BoxFit.cover,
                              )),
                          ListTile(
                              subtitle: ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    RatingBarIndicator(
                                      rating: snapshotData.docs[index]
                                          .data()["rating"]
                                          .toDouble(),
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: ColorsConst.amber,
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
                                  Text(snapshotData.docs[index].data()['name']),
                                  Text(
                                    "${_getDistance(snapshotData.docs[index].data()['location'])} km",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              )),
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
    }

    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GetBuilder<Querying>(
                builder: (val) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ColorsConst.buttonTheme,
                      child: Text(
                        "All",
                        style: TextStyle(color: ColorsConst.white),
                      ),
                      onPressed: () {
                        val.getAllData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                    ),
                  );
                },
                init: Querying(),
              ),
              GetBuilder<Querying>(
                builder: (val) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ColorsConst.buttonTheme,
                      child: Text(
                        "Restaurant",
                        style: TextStyle(color: ColorsConst.white),
                      ),
                      onPressed: () {
                        val.getRestaurantData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                    ),
                  );
                },
                init: Querying(),
              ),
              GetBuilder<Querying>(
                builder: (val) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ColorsConst.buttonTheme,
                      child: Text(
                        "Cafe",
                        style: TextStyle(color: ColorsConst.white),
                      ),
                      onPressed: () {
                        val.getCafeData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                    ),
                  );
                },
                init: Querying(),
              ),
              GetBuilder<Querying>(
                builder: (val) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ColorsConst.buttonTheme,
                      child: Text(
                        "Burger&Pizza",
                        style: TextStyle(color: ColorsConst.white),
                      ),
                      onPressed: () {
                        val.getBurgerData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                    ),
                  );
                },
                init: Querying(),
              ),
              GetBuilder<Querying>(
                builder: (val) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ColorsConst.buttonTheme,
                      child: Text(
                        "Fasting",
                        style: TextStyle(color: ColorsConst.white),
                      ),
                      onPressed: () {
                        val.getFastingData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                    ),
                  );
                },
                init: Querying(),
              ),
              GetBuilder<Querying>(
                builder: (val) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ColorsConst.buttonTheme,
                      child: Text(
                        "Pasta",
                        style: TextStyle(color: ColorsConst.white),
                      ),
                      onPressed: () {
                        val.getPastaData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                    ),
                  );
                },
                init: Querying(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Restaurants nearby',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        isExecuted ? searchedData() : RestaurantList(),
      ],
    );
  }
}
