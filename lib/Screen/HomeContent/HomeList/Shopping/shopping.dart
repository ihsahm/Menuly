import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Querying/ShopQuery/shop_query.dart';
import 'package:e_commerce/Screen/HomeContent/HomeList/Shopping/Content/shopping_content.dart';
import 'package:e_commerce/Services/GetCurrentLocation/getLocation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'Details/shopping_details.dart';

class Shopping extends StatefulWidget {
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  bool isExecuted = false;
  QuerySnapshot snapshotData;

  LocationProvider locationProvider = new LocationProvider();
  final ScrollController controller = new ScrollController();

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
                      builder: (BuildContext context) => ShoppingDetails(
                            name: "${snapshotData.docs[index].data()['name']}",
                            phone:
                                "${snapshotData.docs[index].data()['phone']}",
                            type: "${snapshotData.docs[index].data()['type']}",
                            image:
                                "${snapshotData.docs[index].data()['image']}",
                            latitude:
                                "${snapshotData.docs[index].data()['latitude']}",
                            longitude:
                                "${snapshotData.docs[index].data()['longitude']}",
                            userlocationLatitude: locationProvider.passlat,
                            userlocationLongitude: locationProvider.passlong,
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
                                    ShoppingDetails(
                                      name:
                                          "${snapshotData.docs[index].data()['name']}",
                                      phone:
                                          "${snapshotData.docs[index].data()['phone']}",
                                      type:
                                          "${snapshotData.docs[index].data()['type']}",
                                      image:
                                          "${snapshotData.docs[index].data()['image']}",
                                      latitude:
                                          "${snapshotData.docs[index].data()['latitude']}",
                                      longitude:
                                          "${snapshotData.docs[index].data()['longitude']}",
                                      userlocationLatitude:
                                          locationProvider.passlat,
                                      userlocationLongitude:
                                          locationProvider.passlong,
                                    )));
                      },
                      title: Text(
                        snapshotData.docs[index].data()['name'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      subtitle: FutureBuilder<String>(
                        future: locationProvider.getCurrentLocation(
                            '${snapshotData.docs[index].data()['latitude']}',
                            '${snapshotData.docs[index].data()['longitude']}'),
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return ListView(children: [
      Wrap(
        runSpacing: 0.0,
        spacing: 2.0,
        children: [
          GetBuilder<ShopQuery>(
            builder: (val) {
              return Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.greenAccent[400]),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
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
            init: ShopQuery(),
          ),
          GetBuilder<ShopQuery>(
            builder: (val) {
              return Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.greenAccent[400]),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        );
                      })),
                  child: Text("Supermarket"),
                  onPressed: () {
                    val.getSuperMarket().then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                  },
                ),
              );
            },
            init: ShopQuery(),
          ),
          GetBuilder<ShopQuery>(
            builder: (val) {
              return Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.greenAccent[400]),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (_) {
                        return RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        );
                      })),
                  child: Text("Minimarket"),
                  onPressed: () {
                    val.getMiniMarket().then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                  },
                ),
              );
            },
            init: ShopQuery(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Shops nearby',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          isExecuted ? searchedData() : ShoppingList(),
        ],
      )
    ]);
  }
}
