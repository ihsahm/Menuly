import 'package:e_commerce/Contents/EventsContent/EventDetail/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:ussd/ussd.dart';

class EventDetailScreen extends StatefulWidget {
  final ticketPrice;
  final ticketName;
  final ticketDescription;
  final ticketImage;

  const EventDetailScreen(
      {Key key,
      this.ticketPrice,
      this.ticketDescription,
      this.ticketImage,
      this.ticketName});
  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () {},
          ),
        ],
        title: Text(
          'Event Details',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        backgroundColor: Colors.white24,
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        height: 50,
        child: FlatButton.icon(
          icon: Icon(
            Icons.attach_money,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text('Buy ticket?'),
                      content: const Text('Do you want to buy this ticket?'),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        FlatButton(
                          onPressed: () {
                            Ussd.runUssd(
                                "*806*0907268733*${widget.ticketPrice}#");
                          },
                          child: Text('Buy now'),
                        )
                      ],
                    ));
          },
          label: Text('Buy Ticket',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      body: EventDetail(
        eventDetail: widget.ticketDescription,
        eventPicture: widget.ticketImage,
        eventPrice: widget.ticketPrice,
        eventName: widget.ticketName,
      ),
    );
  }
}
