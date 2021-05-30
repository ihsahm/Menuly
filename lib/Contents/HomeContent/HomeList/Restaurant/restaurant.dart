import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Restaurant/restaurant_list.dart';
import 'package:e_commerce/Database/Querying/RestaurantQuery/restaurant_query_list.dart';
import 'package:e_commerce/Services/GetCurrentLocation/getLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:progress_indicators/progress_indicators.dart';

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

  LocationProvider locationProvider = new LocationProvider();

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        controller: controller,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AreaDetailScreen(
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
                            userlocationLatitude: locationProvider.passlat,
                            userlocationLongtiude: locationProvider.passlong,
                          )));
            },
            child: Card(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      )
                    ]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: snapshotData.docs[index].data()['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    AreaDetailScreen(
                                      restaurantName:
                                          "${snapshotData.docs[index].data()['name']}",
                                      restaurantMenu:
                                          snapshotData.docs[index].id,
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
                      title: Text(
                        "${snapshotData.docs[index].data()['name']}",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      subtitle: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            FutureBuilder<String>(
                              future: locationProvider.getCurrentLocation(
                                  '${snapshotData.docs[index].data()['latitude']}',
                                  '${snapshotData.docs[index].data()['longtiude']}'),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                List<Widget> children;
                                if (snapshot.hasData) {
                                  children = <Widget>[
                                    Text('Distance: ${snapshot.data}'),
                                  ];
                                } else {
                                  children = <Widget>[
                                    JumpingText(
                                      'Calculating distance...',
                                    ),
                                  ];
                                }

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: children,
                                );
                              },
                            ),
                            RatingBarIndicator(
                              rating: snapshotData.docs[index]
                                  .data()["rating"]
                                  .toDouble(),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // runSpacing: 0.0,
            //   spacing: 2.0,
            children: [
              GetBuilder<Querying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent[400]),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            );
                          })),
                      child: Text("All"),
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
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent[400]),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            );
                          })),
                      child: Text("Restaurant"),
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
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent[400]),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            );
                          })),
                      child: Text("Cafe"),
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
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent[400]),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            );
                          })),
                      child: Text("Burger&Pizza"),
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
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent[400]),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            );
                          })),
                      child: Text("Fasting"),
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
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent[400]),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                                  (_) {
                            return RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            );
                          })),
                      child: Text("Pasta"),
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
