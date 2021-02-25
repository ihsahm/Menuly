import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Screen/AreaDetailPage/area_detail_screen.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CafeList extends StatefulWidget {
  @override
  _CafeListState createState() => _CafeListState();
}

class _CafeListState extends State<CafeList> {
  Stream items;
  GetData crudObj = new GetData();
  @override
  void initState() {
    crudObj.getCafeData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

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
                              builder: (BuildContext context) =>
                                  AreaDetailScreen(
                                    restaurantName:
                                        "${doc[index].data()['name']}",
                                    restaurantMenu: doc[index].documentID,
                                    restaurantEmail:
                                        "${doc[index].data()['email']}",
                                    restaurantInstagram:
                                        "${doc[index].data()['instagram']}",
                                    restaurantFacebook:
                                        "${doc[index].data()['facebook']}",
                                    restaurantPhone:
                                        "${doc[index].data()['phone']}",
                                    restaurantImage:
                                        "${doc[index].data()['image']}",
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
                              child: ExtendedImage.network(
                                "${doc[index].data()['image']}",
                                fit: BoxFit.cover,
                                cache: true,
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
                                                  "${doc[index].data()['name']}",
                                              restaurantImage:
                                                  "${doc[index].data()['image']}",
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
                                '${doc[index].data()['name']}',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                  "Distance: ${doc[index].data()['distance']} km."),
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
                child: Center(child: CircularProgressIndicator()),
              );
            }
          }),
    );
  }
}
