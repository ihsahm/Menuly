import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:e_commerce/Services/GetCurrentLocation/getLocation.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class NearbyTest extends StatefulWidget {
  @override
  _NearbyTestState createState() => _NearbyTestState();
}

class _NearbyTestState extends State<NearbyTest> {
  PaginateRefreshedChangeListener refreshedChangeListener =
      new PaginateRefreshedChangeListener();
  LocationProvider locationProvider = new LocationProvider();
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
    String getDistance(location) {
      var distance = Geolocator.distanceBetween(locationProvider.passlat,
          locationProvider.passlong, location.latitude, location.longitude);
      var distanceInKm = distance / 1000;
      return distanceInKm.toStringAsFixed(2);
    }

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: items,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Error');
          }
          List shopDistance = [];
          for (int i = 0; i <= snapshot.data.docs.length - 1; i++) {
            var distance = Geolocator.distanceBetween(
              locationProvider.passlat,
              locationProvider.passlong,
              snapshot.data.docs[i]['location'].laitude,
              snapshot.data.docs[i]['location'].longtude,
            );
            var distanceInKm = distance / 1000;
            shopDistance.add(distanceInKm);
          }
          shopDistance.sort();
          if (shopDistance[0] > 10) {
            return Container(
              child: Text('no nearby found'),
            );
          }
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                RefreshIndicator(
                  child: PaginateFirestore(
                    query:
                        FirebaseFirestore.instance.collection("Entertainment"),
                    listeners: [refreshedChangeListener],
                    footer: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        child: Stack(
                          children: [Center(child: Text('Thats All'))],
                        ),
                      ),
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilderType: PaginateBuilderType.listView,
                    itemBuilder: (index, context, document) => Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(snapshot.data.docs[index].data()['name']),
                            Text('${getDistance(document)} km'),
                          ]),
                    ),
                    header: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('All nearby business')],
                    ),
                    bottomLoader: CircularProgressIndicator(),
                  ),
                  onRefresh: () async {
                    refreshedChangeListener.refreshed = true;
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
