import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  final eventPicture;
  final eventDetail;
  final eventLocation;
  final eventAvailable;
  final eventName;
  final eventDate;
  final eventPrice;

  const EventDetail(
      {Key key,
      this.eventPicture,
      this.eventDetail,
      this.eventPrice,
      this.eventName,
      this.eventDate,
      this.eventAvailable,
      this.eventLocation})
      : super(key: key);
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: widget.eventPicture,
            // cache: true,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, bottom: 10, left: 5.0),
          child: RichText(
            text: TextSpan(
                text: 'Price: ',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[500]),
                children: <TextSpan>[
                  TextSpan(
                    text: "${widget.eventPrice} br.",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  )
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 10, left: 5.0),
          child: RichText(
            text: TextSpan(
                text: 'Location: ',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[500]),
                children: <TextSpan>[
                  TextSpan(
                    text: "${widget.eventLocation}",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  )
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 10, left: 5.0),
          child: RichText(
            text: TextSpan(
                text: 'Tickets available at: ',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey[500]),
                children: <TextSpan>[
                  TextSpan(
                    text: widget.eventAvailable,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                  )
                ]),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.eventDetail,
              style: TextStyle(color: Colors.blueGrey[800]),
            ))
      ],
    );
  }
}
