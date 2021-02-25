import 'dart:async';

import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Screen/AreaDetailPage/area_detail_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RestaurantList extends StatefulWidget {
  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  Timer timer;
  Stream items;
  GetData crudObj = new GetData();

  double distance = 0;
  var locationMessage = "";
  @override
  void initState() {
    crudObj.getRestaurantData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  void getCurrentLocation(double slatitude, double slongitude) async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      locationMessage = "${position.latitude},${position.longitude}";
      distance = Geolocator.distanceBetween(
          position.latitude, position.longitude, slatitude, slongitude);
    });
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
                                    restaurantInstagram:
                                        "${doc[index].data()['instagram']}",
                                    restaurantFacebook:
                                        "${doc[index].data()['facebook']}",
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
                              child: ExtendedImage.network(
                                "${doc[index].data()['image']}",
                                fit: BoxFit.cover,
                                cache: true,
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
                                                  "${doc[index].data()['name']}",
                                              restaurantImage:
                                                  "${doc[index].data()['image']}",
                                              restaurantMenu:
                                                  doc[index].documentID,
                                              restaurantEmail:
                                                  "${doc[index].data()['email']}",
                                              restaurantInstagram:
                                                  "${doc[index].data()['instagram']}",
                                              restaurantFacebook:
                                                  "${doc[index].data()['facebook']}",
                                              restaurantPhone:
                                                  "${doc[index].data()['phone']}",
                                              restaurantType:
                                                  "${doc[index].data()['type']}",
                                            )));
                              },
                              title: Text(
                                '${doc[index].data()['name']}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text("Distance: $distance km."),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          }),
    );
  }
}
