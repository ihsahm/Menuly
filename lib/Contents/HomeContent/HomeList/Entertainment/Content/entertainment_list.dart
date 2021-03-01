import 'dart:async';

import 'package:e_commerce/Database/Download/getData.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class EntertainmentList extends StatefulWidget {
  @override
  _EntertainmentListState createState() => _EntertainmentListState();
}

class _EntertainmentListState extends State<EntertainmentList> {
  Timer timer;
  Stream items;
  GetData crudObj = new GetData();
  @override
  void initState() {
    crudObj.getEntertainmentData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: StreamBuilder(
          stream: items,
          builder: (context, snapshot) {
            var doc = snapshot.data.documents;
            if (snapshot.data != null) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
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
                                /*    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HotelDetails(
                                              name:
                                                  "${doc[index].data()['restaurantName']}",
                                              room: doc[index].documentID,
                                              email:
                                                  "${doc[index].data()['email']}",
                                              instagram:
                                                  "${doc[index].data()['instagram']}",
                                              facebook:
                                                  "${doc[index].data()['facebook']}",
                                              phone:
                                                  "${doc[index].data()['phone']}",
                                              /* restaurantType:
                                        "${doc[index].data()['type']}",
                                  ))*/

                                         //     latitude:
                                                  "${doc[index].data()['latitude']}",
                                           //   longitude:
                                                  "${doc[index].data()['longitude']}",
                                           //   userlocationLatitude: passlat,
                                            //  userlocationLongitude: passlong,
                                            )));*/
                              },
                              title: Text(
                                '${doc[index].data()['name']}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              /*  subtitle: FutureBuilder<String>(
                                future: getCurrentLocation(
                                    '${doc[index].data()['latitude']}',
                                    '${doc[index].data()['longitude']}'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: children,
                                  );
                                },
                              ),*/
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
