import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Screen/AreaDetailPage/area_detail_screen.dart';
import 'package:flutter/material.dart';

class VegeterianList extends StatefulWidget {
  @override
  _VegeterianListState createState() => _VegeterianListState();
}

class _VegeterianListState extends State<VegeterianList> {
  Stream items;
  GetData crudObj = new GetData();
  @override
  void initState() {
    crudObj.getVegeterianData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  final myListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: StreamBuilder(
          stream: items,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              var doc = snapshot.data.documents;
              return AnimatedList(
                shrinkWrap: true,
                key: myListKey,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                initialItemCount: doc.length,
                itemBuilder: (BuildContext context, int index, animation) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AreaDetailScreen(
                                    restaurantName:
                                        "${doc[index].data()['restaurantName']}",
                                    restaurantMenu: doc[index].documentID,
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
                              child: Image.network(
                                "${doc[index].data()['image']}",
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
                                                  "${doc[index].data()['restaurantName']}",
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
                                '${doc[index].data()['restaurantName']}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                  "Distance: ${doc[index].data()['distance']} km."), //\nDistance: ${snapshot.data.documents[index].data()['distance']}km \n"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
