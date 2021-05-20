import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Entertainment/Content/entertainment_list.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Entertainment/Details/entertainment_details.dart';
import 'package:e_commerce/Database/Querying/EntertainmentQuery/entertainment_query_list.dart';
import 'package:e_commerce/Database/Querying/RestaurantQuery/restaurant_query_list.dart';
import 'package:e_commerce/zRealDistance/AssistantMethods.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Entertainment extends StatefulWidget {
  @override
  _EntertainmentState createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment> {
  final TextEditingController searchController = new TextEditingController();

  final ScrollController controller = new ScrollController();
  QuerySnapshot snapshotData;
  bool isExecuted = false;
  final double height = 400;

  double distance = 0;
  var locationMessage = "";
  var passlat;
  var passlong;
  @override
  Future<String> getCurrentLocation(String slatitude, String slongitude) async {
    var slat = double.parse(slatitude);
    var slon = double.parse(slongitude);
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    passlat = position.latitude;
    passlong = position.longitude;
    // distance = Geolocator.distanceBetween(
    //     position.latitude, position.longitude, slat, slon);
    // distance = distance.roundToDouble() / 1000;
    // String temp = distance.toStringAsFixed(2);

    LatLng a = LatLng(passlat, passlong);
    LatLng b = LatLng(slat, slon);

    var details = await AssistantMethods.obtainDirectionDetails(a, b);
    return details.distanceText;
  }

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
                      builder: (BuildContext context) => EntertainmentDetails(
                            name: "${snapshotData.docs[index].data()['name']}",
                            info: "${snapshotData.docs[index].data()['info']}",
                            phone:
                                "${snapshotData.docs[index].data()['phone']}",
                            image:
                                "${snapshotData.docs[index].data()['image']}",
                            latitude:
                                "${snapshotData.docs[index].data()['latitude']}",
                            longitude:
                                "${snapshotData.docs[index].data()['longitude']}",
                            userlocationLatitude: passlat,
                            userlocationLongitude: passlong,
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
                                    EntertainmentDetails(
                                      name:
                                          "${snapshotData.docs[index].data()['name']}",
                                      info:
                                          "${snapshotData.docs[index].data()['info']}",
                                      phone:
                                          "${snapshotData.docs[index].data()['phone']}",
                                      image:
                                          "${snapshotData.docs[index].data()['image']}",
                                      latitude:
                                          "${snapshotData.docs[index].data()['latitude']}",
                                      longitude:
                                          "${snapshotData.docs[index].data()['longitude']}",
                                      userlocationLatitude: passlat,
                                      userlocationLongitude: passlong,
                                    )));
                      },
                      title: Text(
                        "${snapshotData.docs[index].data()['name']}",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      subtitle: FutureBuilder<String>(
                        future: getCurrentLocation(
                            '${snapshotData.docs[index].data()['latitude']}',
                            '${snapshotData.docs[index].data()['longtiude']}'),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            children = <Widget>[
                              Text('Distance: ${snapshot.data} km.'),
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
              GetBuilder<EntertainmentQuery>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.greenAccent[400],
                      child: Text("All"),
                      onPressed: () {
                        val.getAllData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: EntertainmentQuery(),
              ),
              GetBuilder<EntertainmentQuery>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.greenAccent[400],
                      child: Text("Gamezones"),
                      onPressed: () {
                        val.getGameZoneData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: EntertainmentQuery(),
              ),
              GetBuilder<EntertainmentQuery>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.greenAccent[400],
                      child: Text("Cinema"),
                      onPressed: () {
                        val.getCinemaData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: EntertainmentQuery(),
              ),
              GetBuilder<EntertainmentQuery>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.greenAccent[400],
                      child: Text("Theater"),
                      onPressed: () {
                        val.getTheaterData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: EntertainmentQuery(),
              ),
              GetBuilder<EntertainmentQuery>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.greenAccent[400],
                      child: Text("Parks"),
                      onPressed: () {
                        val.getParksData().then((value) {
                          snapshotData = value;
                          setState(() {
                            isExecuted = true;
                          });
                        });
                      },
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  );
                },
                init: EntertainmentQuery(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Entertainment nearby',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
        isExecuted ? searchedData() : EntertainmentList(),
      ],
    );
  }
}
