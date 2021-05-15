import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';

class FoodMenu extends StatefulWidget {
  final menuList;

  const FoodMenu({Key key, this.menuList}) : super(key: key);
  @override
  _FoodMenuState createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  @override
  Widget build(BuildContext context) {
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

    final db = FirebaseFirestore.instance
        .collection('Restaurant')
        .doc(widget.menuList)
        .collection('Menu')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: db,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Tap to see food content',
                        style: TextStyle(color: Colors.blueGrey),
                      )),
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
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height: 200,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                          title: Text(
                                        'Contents',
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      )),
                                      ListTile(
                                        title: Text(
                                          ((doc[index].data()['contents'] !=
                                                  null)
                                              ? doc[index].data()['contents']
                                              : 'Contents not provided'),
                                          style:
                                              TextStyle(color: Colors.blueGrey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: ButtonTheme(
                                            minWidth: 30,
                                            child: FlatButton(
                                              child: Text(
                                                'Okay',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ));
                            });
                        // showDialog<void>(
                        //   context: context,
                        //   builder: (BuildContext context) => showModalBottomSheet(
                        //     title: Text('Contents'),
                        //     content: Text(
                        //         ((doc[index].data()['contents'] != null)
                        //             ? doc[index].data()['contents']
                        //             : 'Contents not provided')),
                        //     actions: [
                        //       FlatButton(
                        //           child: Text('Okay'),
                        //           onPressed: () {
                        //             Navigator.pop(context);
                        //           })
                        //     ],
                        //   ),
                        // );
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
              ],
            ),
          );
        } else {
          return Center(
            child: Image.asset('assets/loading.gif'),
          );
        }
      },
    );
  }
}
