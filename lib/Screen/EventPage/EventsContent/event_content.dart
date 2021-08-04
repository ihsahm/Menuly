import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/Consts/colors.dart';
import 'package:e_commerce/Consts/loading.dart';
import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Screen/EventPage/EventsContent/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
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
            return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DateTime eventDay = DateTime.fromMillisecondsSinceEpoch(
                      (snapshot.data.documents[index].data()['date']));
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
                                          ticketLocation:
                                              "${snapshot.data.documents[index].data()['location']}",
                                          ticketImage:
                                              "${snapshot.data.documents[index].data()['image']}",
                                          ticketName:
                                              "${snapshot.data.documents[index].data()['ticketName']}",
                                        )));
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.6,
                            child: Container(
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${snapshot.data.documents[index].data()['image']}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
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
                                          ticketLocation:
                                              "${snapshot.data.documents[index].data()['location']}",
                                          ticketDescription:
                                              "${snapshot.data.documents[index].data()['details']}",
                                          ticketImage:
                                              "${snapshot.data.documents[index].data()['image']}",
                                          ticketName:
                                              "${snapshot.data.documents[index].data()['ticketName']}",
                                        )));
                          },
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 0.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${snapshot.data.documents[index].data()['ticketName']}",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.date_range),
                                      title: Text(
                                        DateFormat.yMMMMd().format(eventDay),
                                      ),
                                    ),
                                    ListTile(
                                      leading: Icon(FontAwesome.dollar),
                                      title: Text(
                                        "${snapshot.data.documents[index].data()['price']} br",
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          'Tap to see more...',
                                          style: TextStyle(
                                              color: ColorsConst.blue600),
                                        ))
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return LoadingShow.loadingProgress;
          }
        });
  }
}
