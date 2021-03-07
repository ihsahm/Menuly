import 'package:e_commerce/Database/Download/getData.dart';
import 'package:e_commerce/Screen/EventPage/EventDetail/event_detail_screen.dart';
import 'package:flutter/material.dart';

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
                                          ticketDate:
                                              "${snapshot.data.documents[index].data()['date']}",
                                          ticketDescription:
                                              "${snapshot.data.documents[index].data()['details']}",
                                          ticketImage:
                                              "${snapshot.data.documents[index].data()['image']}",
                                          ticketName:
                                              "${snapshot.data.documents[index].data()['ticketName']}",
                                        )));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 8, bottom: 4),
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "${snapshot.data.documents[index].data()['image']}",
                                    )),
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
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "${snapshot.data.documents[index].data()['ticketName']}" +
                                        "\n" +
                                        "${snapshot.data.documents[index].data()['date']}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
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
