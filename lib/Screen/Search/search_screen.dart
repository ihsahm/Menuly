import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Search/search.dart';
import 'package:e_commerce/Screen/HomeContent/HomeList/Restaurant/RestaurantDetailPage/restaurant_detail_screen.dart';
import 'package:e_commerce/Services/GetCurrentLocation/getLocation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  QuerySnapshot snapshot;
  final TextEditingController searchController = new TextEditingController();
  LocationProvider locationProvider = new LocationProvider();

  QuerySnapshot snapshotData;
  bool isExecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
                onTap: () {
                  //  Get.to(
                  //    AreaDetailScreen(),
                  //    transition: Transition.downToUp,
                  //    arguments: snapshotData.docs[index],
                  //  );
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
                                restaurantLatitude: locationProvider.passlat,
                                restaurantLongtitude: locationProvider.passlong,
                              )));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    snapshotData.docs[index].data()['image'],
                  ),
                  radius: 20,
                ),
                title: Text(
                  snapshotData.docs[index].data()['name'],
                  style: TextStyle(fontSize: 17),
                )),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(top: 28.0, bottom: 28.0),
          child: TextField(
            style: TextStyle(color: Colors.black),
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              // GetBuilder<Search>(
              //   builder: (val) {
              //     return IconButton(
              //         color: Colors.black,
              //         icon: Icon(Icons.search),
              //         onPressed: () {});
              //   },
              //   init: Search(),
              // );
            },
            decoration: InputDecoration(
              hintText: 'Search...',
            ),
            controller: searchController,
            textCapitalization: TextCapitalization.words,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          GetBuilder<Search>(
            builder: (val) {
              return IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.search),
                  onPressed: () {
                    val.queryHotelData(searchController.text).then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                    val
                        .queryRestaurantData(searchController.text)
                        .then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                    val.queryCafeData(searchController.text).then((value) {
                      snapshotData = value;
                      setState(() {
                        isExecuted = true;
                      });
                    });
                  });
            },
            init: Search(),
          ),
        ],
      ),
      body: isExecuted
          ? searchedData()
          : Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dinner_dining),
                    Text('Search for anything...'),
                  ],
                ),
              ),
            ),
    );
  }
}
