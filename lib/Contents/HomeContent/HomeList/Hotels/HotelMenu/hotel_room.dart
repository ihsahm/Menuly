import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class RoomDetails extends StatefulWidget {
  final room;
  final price;

  const RoomDetails({Key key, this.room, this.price}) : super(key: key);
  @override
  _RoomDetailsState createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection('Hotels')
          .doc(widget.room)
          .collection('Rooms')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
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
                      leading: Icon(
                        FontAwesome.bed,
                        color: Colors.amber[900],
                      ),
                      title: Text("${doc[index].data()['roomName']}"),
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
