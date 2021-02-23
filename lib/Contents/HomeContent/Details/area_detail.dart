import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AreaDetails extends StatefulWidget {
  final menuDoc;
  final type;
  final email;
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
      this.image});

  @override
  _AreaDetailsState createState() => _AreaDetailsState();
}

class _AreaDetailsState extends State<AreaDetails> {
  Stream items;

  GetData crudObj = new GetData();

  @override
  void initState() {
    crudObj.getMenuData().then((results) {
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
      stream: db
          .collection('Restaurant')
          .doc(widget.menuDoc)
          .collection('Menu')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                /*    SizedBox(
                  child: Image.network(
                    "https://media.istockphoto.com/vectors/line-fast-food-icons-vector-id1132000293?b=1&k=6&m=1132000293&s=612x612&w=0&h=YbBlqZ6fKTjHzYZnMoCzb1nioUuoSpiAidEn7y2Rnbs=",
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: Text(
                      'Menu',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var doc = snapshot.data.docs;
                    return ListTile(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Contents'),
                            content: Text('${doc[index].data()['contents']}'),
                            actions: [
                              FlatButton(
                                  child: Text('Okay'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        );
                      },
                      leading: Icon(
                        Linecons.food,
                        color: Colors.amber[900],
                      ),
                      title: Text("${doc[index].data()['foodName']}"),
                      subtitle: Text("${doc[index].data()['price']} Br."),
                    );
                  },
                ),
                Divider(
                  thickness: 20,
                ),
                /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton.icon(
                            icon: Icon(Icons.phone),
                            onPressed: () {
                              launch('tel:${widget.phone}');
                            },
                            label: Text('Call')),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton.icon(
                            icon: Icon(Icons.message),
                            onPressed: () {
                              launch('sms: ${widget.phone}');
                            },
                            label: Text('Message')),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(50)),
                        child: FlatButton.icon(
                            icon: Icon(Icons.report),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Wrap(
                                      children: [
                                        ListTile(
                                          title: Text('Fake or fraud business'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: Text('Inappropriate'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: Text('Promotes violence'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                          title: Text('Other'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            label: Text('Report')),
                      ),
                    ],
                  ),
                ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: Text(
                      'Information',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.info,
                            color: Colors.blue[900],
                          ),
                          title: Text(widget.type),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                          title: Text(widget.phone),
                          onTap: () {
                            launch('tel:${widget.phone}');
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email_outlined,
                            color: Colors.red[700],
                          ),
                          title: Text(widget.email),
                          onTap: () {
                            launch('mailto: ${widget.email}');
                          },
                        ),
                        ListTile(
                          leading: Icon(Entypo.facebook_squared,
                              color: Colors.blue[700]),
                          title: Text('Like us on facebook'),
                          onTap: () {
                            launch('url: ${widget.facebook}');
                          },
                        ),
                        ListTile(
                          leading: Icon(FontAwesome5.instagram,
                              color: Colors.pink[300]),
                          title: Text('Follow us on instagram'),
                          onTap: () {
                            launch('url:${widget.instagram}');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
