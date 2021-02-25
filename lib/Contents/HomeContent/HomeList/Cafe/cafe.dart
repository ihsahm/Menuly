import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Cafe/cafe_list.dart';
import 'package:e_commerce/Database/Querying/CafeQuery/cafe_query.dart';
import 'package:e_commerce/Screen/AreaDetailPage/area_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CafeMenu extends StatefulWidget {
  @override
  _CafeMenuState createState() => _CafeMenuState();
}

class _CafeMenuState extends State<CafeMenu> {
  final TextEditingController searchController = new TextEditingController();

  final ScrollController controller = new ScrollController();
  QuerySnapshot snapshotData;
  bool isExecuted = false;
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
                      builder: (BuildContext context) => AreaDetailScreen(
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
                      child: Image.network(
                        snapshotData.docs[index].data()['image'],
                        fit: BoxFit.cover,
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
                                          "${snapshotData.docs[index].data()['name']}",
                                      restaurantMenu:
                                          snapshotData.docs[index].id,
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
                                    )));
                      },
                      title: Text(
                        snapshotData.docs[index].data()['name'],
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text("Distance: 1 km."),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Wrap(
            runSpacing: 0.0,
            spacing: 2.0,
            children: [
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
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
                init: CafeQuerying(),
              ),
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("Cakes"),
                      onPressed: () {
                        val.getCakeData().then((value) {
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
                init: CafeQuerying(),
              ),
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("Coffee"),
                      onPressed: () {
                        val.getCoffeeData().then((value) {
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
                init: CafeQuerying(),
              ),
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("IceCream"),
                      onPressed: () {
                        val.getIceCreamData().then((value) {
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
                init: CafeQuerying(),
              ),
              GetBuilder<CafeQuerying>(
                builder: (val) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 1.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.orange,
                      child: Text("Juice&Smoothie"),
                      onPressed: () {
                        val.getJuiceData().then((value) {
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
                init: CafeQuerying(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Cafe nearby',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          isExecuted ? searchedData() : CafeList(),
        ],
      ),
    );
  }
}
