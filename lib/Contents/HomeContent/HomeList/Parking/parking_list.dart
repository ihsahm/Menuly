import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/zRealDistance/AssistantMethods.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingList extends StatefulWidget {
  @override
  _ParkingListState createState() => _ParkingListState();
}

class _ParkingListState extends State<ParkingList> {
  QuerySnapshot snapshot;
  int itemindex;
  Future<void> _launchInApp() async {
    var url =
        "https://www.google.com/maps/dir/${passlat},${passlong}/${snapshot.docs[itemindex].data()['latitude']},${snapshot.docs[itemindex].data()['longitude']}/@8.9817088,38.7284248,15z";
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
        enableDomStorage: true,
        enableJavaScript: true,
      );
    }
  }

  Timer timer;
  Stream items;

  GetData crudObj = new GetData();
  @override
  void initState() {
    crudObj.getParkingData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  double distance = 0;
  var locationMessage = "";
  var passlat;
  var passlong;

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
    return StreamBuilder(
      stream: items,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          var doc = snapshot.data.documents;
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: doc.length,
            itemBuilder: (context, int index) {
              return ListTile(
                leading: Icon(
                  Icons.local_parking_outlined,
                  color: Colors.red,
                ),
                title: Text(
                  '${doc[index].data()['name']}',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                subtitle: Text('Distance: 5.4km'),
                // subtitle: FutureBuilder<String>(
                //   future: getCurrentLocation('${doc[index].data()['latitude']}',
                //       '${doc[index].data()['longtiude']}'),
                //   builder:
                //       (BuildContext context, AsyncSnapshot<String> snapshot) {
                //     List<Widget> children;
                //     if (snapshot.hasData) {
                //       children = <Widget>[
                //         Text('Distance: ${snapshot.data} km.'),
                //       ];
                //     } else {
                //       children = <Widget>[
                //         JumpingText('Calculating distance...'),
                //       ];
                //     }

                //     return Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: children,
                //     );
                //   },
                // ),
                /*    onTap: () {
                  _launchInApp();
                },*/
              );
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Center(child: Image.asset('assets/loading.gif')),
          );
        }
      },
    );
  }
}
