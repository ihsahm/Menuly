import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Entertainment/Details/entertainment_details.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Entertainment/entertainment.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/HotelDetails/hotel_details.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/hotel.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Parking/parking.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Restaurant/RestaurantDetailPage/restaurant_detail_screen.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Restaurant/restaurant.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Shopping/Details/shopping_details.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Shopping/shopping.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:geolocator/geolocator.dart';

class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  @override
  Widget build(BuildContext context) {
    final tabPages = <Widget>[
      RestaurantMenu(),
      //  CafeMenu(),
      Hotel(),

      Shopping(),
      Entertainment(),
      // Parking(),
    ];
    final tabIcon = <Tab>[
      Tab(
        icon: Icon(
          Icons.dinner_dining,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Restaurants',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),
      // Tab(
      //   icon: Icon(
      //     LineariconsFree.coffee_cup,
      //     color: Colors.orangeAccent[700],
      //   ),
      //   child: Text(
      //     'Cafes',
      //     style: TextStyle(color: Colors.orangeAccent[700]),
      //   ),
      // ),
      Tab(
        icon: Icon(
          Icons.hotel,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Hotels',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),

      Tab(
        icon: Icon(
          Icons.shopping_bag,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Shopping',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),

      Tab(
        icon: Icon(
          FontAwesome.gamepad,
          color: Colors.orangeAccent[700],
        ),
        child: Text(
          'Entertainment',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 13),
        ),
      ),
      // Tab(
      //   icon: Icon(
      //     FontAwesome5.parking,
      //     color: Colors.orangeAccent[700],
      //   ),
      //   child: Text(
      //     'Parking',
      //     style: TextStyle(color: Colors.orangeAccent[700]),
      //   ),
      // ),
    ];
    return DefaultTabController(
      length: tabIcon.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text('Menuly', style: TextStyle(color: Colors.blue[700])),
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.green[200],
            isScrollable: true,
            tabs: tabIcon,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
        body: TabBarView(children: tabPages),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  List<dynamic> searchwords = [];

  final recentsearchwords = [];

  var selectedsearchwords = "";
  var suggested;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          selectedsearchwords = "";
        },
      )
    ];
  }

  double passlat = 0;
  double passlong = 0;

  getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    passlat = position.latitude;
    passlong = position.longitude;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    bool notfound = false;
    for (int i = 0; i < searchwords.length; i++) {
      if (searchwords[i] == selectedsearchwords) {
        notfound = true;
        break;
      }
    }

    if (notfound == true) {
      var element;
      element = callsingleRest(context, selectedsearchwords);
      if (element != 0) {
        element = callsingleHotel(context, selectedsearchwords);
        if (element != 0) {
          element = callsingleShopping(context, selectedsearchwords);
          if (element != 0) {
            element = callsingleEntertainment(context, selectedsearchwords);
            if (element != 0) {
              element = callsingleParking(context, selectedsearchwords);
            }
          }
        }
      }
      notfound = false;
      selectedsearchwords = "";
    }
    // TODO: implement buildResults
    return notfound ? Container() : Container();
  }

  callsingleParking(context, word) async {
    await FirebaseFirestore.instance
        .collection('Parking')
        .where('name', isEqualTo: word)
        .get()
        .then((snapshot) {
      if (snapshot.docs.length > 0) {
        return 0;
      }
      return 1;
    });
  }

  callsingleEntertainment(context, word) async {
    await getCurrentLocation();
    await FirebaseFirestore.instance
        .collection('Entertainment')
        .where('name', isEqualTo: word)
        .get()
        .then((snapshot) {
      if (snapshot.docs.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EntertainmentDetails(
                      name: "${snapshot.docs[0].data()['name']}",
                      info: "${snapshot.docs[0].data()['info']}",
                      phone: "${snapshot.docs[0].data()['phone']}",
                      image: "${snapshot.docs[0].data()['image']}",
                      latitude: "${snapshot.docs[0].data()['latitude']}",
                      longitude: "${snapshot.docs[0].data()['longitude']}",
                      userlocationLatitude: passlat,
                      userlocationLongitude: passlong,
                    )));
        return 0;
      }
      return 1;
    });
  }

  callsingleShopping(context, word) async {
    await getCurrentLocation();
    await FirebaseFirestore.instance
        .collection('Shopping')
        .where('name', isEqualTo: word)
        .get()
        .then((snapshot) {
      if (snapshot.docs.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ShoppingDetails(
                      name: "${snapshot.docs[0].data()['name']}",
                      info: "${snapshot.docs[0].data()['info']}",
                      phone: "${snapshot.docs[0].data()['phone']}",
                      type: "${snapshot.docs[0].data()['type']}",
                      image: "${snapshot.docs[0].data()['image']}",
                      latitude: "${snapshot.docs[0].data()['latitude']}",
                      longitude: "${snapshot.docs[0].data()['longitude']}",
                      userlocationLatitude: passlat,
                      userlocationLongitude: passlong,
                    )));
        return 0;
      }
      return 1;
    });
  }

  callsingleHotel(context, word) async {
    await getCurrentLocation();
    await FirebaseFirestore.instance
        .collection('Hotels')
        .where('name', isEqualTo: word)
        .get()
        .then((snapshot) {
      if (snapshot.docs.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HotelDetails(
                      name: "${snapshot.docs[0].data()['restaurantName']}",
                      room: snapshot.docs[0].documentID,
                      email: "${snapshot.docs[0].data()['email']}",
                      instagram: "${snapshot.docs[0].data()['instagram']}",
                      facebook: "${snapshot.docs[0].data()['facebook']}",
                      phone: "${snapshot.docs[0].data()['phone']}",
                      info: "${snapshot.docs[0].data()['info']}",
                      /* restaurantType:
                                        "${snapshot.docs[0].data()['type']}",
                                  ))*/
                      image: "${snapshot.docs[0].data()['image']}",
                      latitude: "${snapshot.docs[0].data()['latitude']}",
                      longitude: "${snapshot.docs[0].data()['longitude']}",
                      userlocationLatitude: passlat,
                      userlocationLongitude: passlong,
                    )));
        return 0;
      }
      return 1;
    });
  }

  callsingleRest(context, word) async {
    await getCurrentLocation();
    await FirebaseFirestore.instance
        .collection('Restaurant')
        .where('name', isEqualTo: word)
        .get()
        .then((snapshot) {
      if (snapshot.docs.length > 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AreaDetailScreen(
                      restaurantName: "${snapshot.docs[0].data()['name']}",
                      restaurantMenu: snapshot.docs[0].id,
                      restaurantImage: "${snapshot.docs[0].data()['image']}",
                      restaurantEmail: "${snapshot.docs[0].data()['email']}",
                      restaurantInstagram:
                          "${snapshot.docs[0].data()['instagram']}",
                      restaurantFacebook:
                          "${snapshot.docs[0].data()['facebook']}",
                      restaurantPhone: "${snapshot.docs[0].data()['phone']}",
                      restaurantType: "${snapshot.docs[0].data()['type']}",
                      userlocationLatitude: passlat,
                      userlocationLongtiude: passlong,
                    )));
        return 0;
      }
      return 1;
    });
  }

  getwordsfirebase() async {
    List<dynamic> words = [];
    await FirebaseFirestore.instance
        .collection('SearchWords')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        words.add(element.data()['name']);
      });
    });
    if (words.length != 0) {
      searchwords = words;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    getwordsfirebase();
    final suggestionList = query.isEmpty
        ? recentsearchwords
        : searchwords.where((p) {
            var temp = query[0].toUpperCase();
            temp += query.substring(1).toLowerCase();
            return p.startsWith(temp);
          }).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          selectedsearchwords = suggestionList[index];
          showResults(context);
        },
        //leading: Icon(Icons),
        title: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
