import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Consts/icons.dart';
import 'package:e_commerce/Consts/loading.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AreaDetails extends StatefulWidget {
  final menuDoc;
  final type;
  final email;
  final rating;
  final facebook;
  final image;
  final phone;
  final instagram;

  const AreaDetails(
      {Key key,
      this.menuDoc,
      this.type,
      this.email,
      this.facebook,
      this.phone,
      this.instagram,
      this.image,
      this.rating});

  @override
  _AreaDetailsState createState() => _AreaDetailsState();
}

class _AreaDetailsState extends State<AreaDetails> {
  Stream items;

  GetData crudObj = new GetData();

  @override
  void initState() {
    crudObj.getRestaurantData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('Restaurant').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: IconsData.info,
                          title: Text('Type'),
                          subtitle: Text(widget.type),
                        ),
                        ListTile(
                          leading: IconsData.phone,
                          title: Text('Phone number'),
                          subtitle: Text(widget.phone),
                          onTap: () {
                            launch('tel:${widget.phone}');
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          title: Text('Rating'),
                          subtitle: RatingBarIndicator(
                            rating: widget.rating.toDouble(),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        )
                        /*   ((widget.email != null)
                            ? ListTile(
                                leading: Icon(
                                  Icons.email_outlined,
                                  color: Colors.red[700],
                                ),
                                title: Text(widget.email),
                                onTap: () {
                                  launch('mailto: ${widget.email}');
                                },
                              )
                            : Container()),*/
                        // ListTile(
                        //   leading: Icon(Entypo.facebook_squared,
                        //       color: Colors.blue[700]),
                        //   title: Text('Like us on facebook'),
                        //   onTap: () {
                        //     //launch('url: ${widget.facebook}').toString();
                        //   },
                        // ),
                        // ListTile(
                        //   leading: Icon(FontAwesome5.instagram,
                        //       color: Colors.pink[300]),
                        //   title: Text('Follow us on instagram'),
                        //   onTap: () {
                        //     //   launch('url:${widget.instagram}');
                        //   },
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return LoadingShow.loadingProgress;
        }
      },
    );
  }
}
