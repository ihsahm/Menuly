import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Screen/EventPage/EventDetail/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventContent extends StatefulWidget {
  @override
  _EventContentState createState() => _EventContentState();
}

class _EventContentState extends State<EventContent> {
  Stream items;
  GetData crudObj = new GetData();

  @override
  void initState() {
    crudObj.getTicketData().then((results) {
      setState(() {
        items = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: items,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime eventDay =
                      (snapshot.data.documents[index].data()['date']).toDate();
                  return Container(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventDetailScreen(
                                          ticketPrice:
                                              "${snapshot.data.documents[index].data()['price']}",
                                          ticketDate: eventDay,
                                          ticketAvailable:
                                              "${snapshot.data.documents[index].data()['available']}",
                                          ticketDescription:
                                              "${snapshot.data.documents[index].data()['details']}",
                                          ticketImage:
                                              "${snapshot.data.documents[index].data()['image']}",
                                          ticketName:
                                              "${snapshot.data.documents[index].data()['ticketName']}",
                                        )));
                          },
                          // child: Stack(
                          //   alignment: Alignment.bottomCenter,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(15),
                          //         ),
                          //         child: CachedNetworkImage(
                          //           imageUrl:
                          //               "${snapshot.data.documents[index].data()['image']}",
                          //           fit: BoxFit.cover,
                          //         ),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.all(25.0),
                          //       child: Align(
                          //         alignment: Alignment.bottomLeft,
                          //         child: RichText(
                          //           text: TextSpan(
                          //             text:
                          //                 "${snapshot.data.documents[index].data()['ticketName']}" +
                          //                     "\n",
                          //             children: <TextSpan>[
                          //               TextSpan(
                          //                   text: DateFormat.yMMMMd()
                          //                       .format(eventDay),
                          //                   style: TextStyle(
                          //                       fontSize: 15,
                          //                       fontWeight: FontWeight.w300))
                          //             ],
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 24,
                          //                 fontWeight: FontWeight.w600),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 8, bottom: 4),
                            height: 300,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "${snapshot.data.documents[index].data()['image']}",
                                    )),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      offset: Offset(-2, -1),
                                      blurRadius: 5),
                                ]),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
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
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          "${snapshot.data.documents[index].data()['ticketName']}" +
                                              "\n",
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: DateFormat.yMMMMd()
                                                .format(eventDay),
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300))
                                      ],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 2, bottom: 4),
                    child: Text("Price: 350 br."),
                  )*/
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: Image.asset('assets/loading.gif'));
          }
        });
  }
}
