import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/HotelDetails/hotel_details.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Services/GetCurrentLocation/getLocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';

class HotelList extends StatefulWidget {
  @override
  _HotelListState createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  Timer timer;
  Stream items;
  GetData crudObj = new GetData();
  @override
  void initState() {
    crudObj.getHotelData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  LocationProvider locationProvider = new LocationProvider();

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
                              builder: (BuildContext context) => HotelDetails(
                                    name:
                                        "${doc[index].data()['restaurantName']}",
                                    room: doc[index].documentID,
                                    email: "${doc[index].data()['email']}",
                                    rating:
                                        doc[index].data()["rating"].toDouble(),
                                    instagram:
                                        "${doc[index].data()['instagram']}",
                                    facebook:
                                        "${doc[index].data()['facebook']}",
                                    phone: "${doc[index].data()['phone']}",
                                    info: "${doc[index].data()['info']}",
                                    /* restaurantType:
                                        "${doc[index].data()['type']}",
                                  ))*/
                                    image: "${doc[index].data()['image']}",
                                    latitude:
                                        "${doc[index].data()['latitude']}",
                                    longitude:
                                        "${doc[index].data()['longitude']}",
                                    userlocationLatitude:
                                        locationProvider.passlat,
                                    userlocationLongitude:
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
                                // cache: true,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HotelDetails(
                                              name:
                                                  "${doc[index].data()['restaurantName']}",
                                              room: doc[index].documentID,
                                              rating: doc[index]
                                                  .data()["rating"]
                                                  .toDouble(),
                                              info:
                                                  "${doc[index].data()['info']}",
                                              image:
                                                  "${doc[index].data()['image']}",
                                              email:
                                                  "${doc[index].data()['email']}",
                                              instagram:
                                                  "${doc[index].data()['instagram']}",
                                              facebook:
                                                  "${doc[index].data()['facebook']}",
                                              phone:
                                                  "${doc[index].data()['phone']}",
                                              latitude:
                                                  "${doc[index].data()['latitude']}",
                                              longitude:
                                                  "${doc[index].data()['longitude']}",
                                              userlocationLatitude:
                                                  locationProvider.passlat,
                                              userlocationLongitude:
                                                  locationProvider.passlong,
                                            )));
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
                                          '${doc[index].data()['longitude']}'),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: children,
                                        );
                                      },
                                    ),
                                    RatingBarIndicator(
                                      rating: doc[index]
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
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Center(
                    child: Column(
                  children: [
                    Lottie.asset('assets/loading.json', animate: true),
                    Text('Loading, please wait'),
                  ],
                )),
              );
            }
          }),
    );
  }
}
