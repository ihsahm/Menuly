import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventDetail extends StatefulWidget {
  final eventPicture;
  final eventDetail;
  final eventName;
  final eventDate;
  final eventPrice;

  const EventDetail(
      {Key key,
      this.eventPicture,
      this.eventDetail,
      this.eventPrice,
      this.eventName,
      this.eventDate})
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
          padding: const EdgeInsets.only(top: 18.0, bottom: 10),
          child: Center(
              child: Text(
            "Price: ${widget.eventPrice} br.",
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[800]),
          )),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 0, bottom: 4),
        //   child: Center(
        //       child: Text(
        //     "${widget.eventDate}",
        //     style: TextStyle(fontSize: 19),
        //   )
        //   ),
        // ),
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
