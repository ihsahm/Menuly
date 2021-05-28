import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Services/GetCurrentLocation/getLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'RestaurantDetailPage/restaurant_detail_screen.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  Timer timer;
  Stream items;
  GetData crudObj = new GetData();
  LocationProvider locationProvider = new LocationProvider();

  @override
  void initState() {
    crudObj.getRestaurantData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: StreamBuilder(
          stream: items,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              var doc = snapshot.data.documents;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: doc.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AreaDetailScreen(
                                    restaurantName:
                                        "${doc[index].data()['name']}",
                                    restaurantMenu: doc[index].documentID,
                                    restaurantImage:
                                        "${doc[index].data()['image']}",
                                    restaurantEmail:
                                        "${doc[index].data()['email']}",
                                    restaurantRating:
                                        doc[index].data()["rating"].toDouble(),
                                    restaurantInstagram:
                                        "${doc[index].data()['instagram']}",
                                    restaurantFacebook:
                                        "${doc[index].data()['facebook']}",
                                    restaurantPhone:
                                        "${doc[index].data()['phone']}",
                                    restaurantType:
                                        "${doc[index].data()['type']}",
                                    restaurantLatitude:
                                        "${doc[index].data()['latitude']}",
                                    restaurantLongtitude:
                                        "${doc[index].data()['longtiude']}",
                                    userlocationLatitude:
                                        locationProvider.passlat,
                                    userlocationLongtiude:
                                        locationProvider.passlong,
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
                                imageUrl: "${doc[index].data()['image']}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             AreaDetailScreen(
                                //               restaurantName:
                                //                   "${doc[index].data()['name']}",
                                //               restaurantImage:
                                //                   "${doc[index].data()['image']}",
                                //               restaurantMenu:
                                //                   doc[index].documentID,
                                //               restaurantEmail:
                                //                   "${doc[index].data()['email']}",
                                //               restaurantInstagram:
                                //                   "${doc[index].data()['instagram']}",
                                //               restaurantFacebook:
                                //                   "${doc[index].data()['facebook']}",
                                //               restaurantPhone:
                                //                   "${doc[index].data()['phone']}",
                                //               restaurantType:
                                //                   "${doc[index].data()['type']}",
                                //             )));
                              },
                              title: Text(
                                '${doc[index].data()['name']}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              subtitle: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  FutureBuilder<String>(
                                    future: locationProvider.getCurrentLocation(
                                        '${doc[index].data()['latitude']}',
                                        '${doc[index].data()['longtiude']}'),
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
                                              'Calculating distance...'),
                                        ];
                                      }

                                      return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: children);
                                    },
                                  ),
                                  RatingBarIndicator(
                                    rating:
                                        doc[index].data()["rating"].toDouble(),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Column(
                children: [
                  Lottie.asset('assets/loading.json', animate: true),
                  Text('Loading, please wait'),
                ],
              );
            }
          }),
    );
  }
}
