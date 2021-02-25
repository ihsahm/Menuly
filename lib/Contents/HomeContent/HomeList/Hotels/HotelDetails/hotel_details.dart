import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/HotelMenu/hotel_contact.dart';
import 'package:e_commerce/Contents/HomeContent/HomeList/Hotels/HotelMenu/hotel_room.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class HotelDetails extends StatefulWidget {
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                floating: false,
                snap: false,
                backgroundColor: Colors.blueGrey,
                pinned: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  /* title: Text(
                      widget.restaurantName,
                    ),*/
                  background: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://media-cdn.tripadvisor.com/media/photo-s/0f/24/62/bb/sheratp-grand-conakry.jpg")),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300],
                              offset: Offset(-2, -1),
                              blurRadius: 5),
                        ]),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              stops: [
                                0.1,
                                0.9
                              ],
                              colors: [
                                Colors.black.withOpacity(.8),
                                Colors.black.withOpacity(.1)
                              ])),
                    ),
                  ),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Text('Menu'),
                    ),
                    Tab(
                      child: Text('Info'),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            RoomDetails(),
            HotelContact(),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: FlatButton.icon(
          icon: Icon(
            FontAwesome.direction,
            color: Colors.white,
          ),
          onPressed: () {},
          label: Text(
            'Get direction',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}

//   ListView(
//     children: [
//       /* Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     children: [
//       Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.grey[300]),
//         child: FlatButton.icon(
//           icon: Icon(Icons.call),
//           label: Text('Call'),
//           onPressed: () {},
//         ),
//       ),
//       Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.grey[300]),
//         child: FlatButton.icon(
//           icon: Icon(Icons.message),
//           label: Text('Message'),
//           onPressed: () {},
//         ),
//       ),
//       Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.grey[300]),
//         child: FlatButton.icon(
//           icon: Icon(Icons.report_rounded),
//           label: Text('Report'),
//           onPressed: () {},
//         ),
//       ),
//     ],
// ),*/
//     ],
//   )
