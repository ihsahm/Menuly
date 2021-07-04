import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:e_commerce/Consts/colors.dart';
import 'package:e_commerce/Consts/icons.dart';
import 'package:e_commerce/Provider/darkThemeprovider.dart';
import 'package:e_commerce/Screen/EventPage/EventsContent/EventDetail/event_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatefulWidget {
  final ticketPrice;
  final ticketName;
  final ticketDate;
  final ticketDescription;
  final ticketLocation;
  final ticketAvailable;
  final ticketImage;

  const EventDetailScreen(
      {Key key,
      this.ticketPrice,
      this.ticketDescription,
      this.ticketImage,
      this.ticketName,
      this.ticketDate,
      this.ticketAvailable,
      this.ticketLocation});
  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    Event event = Event(
      title: widget.ticketName,
      startDate: widget.ticketDate,
      endDate: widget.ticketDate,
      allDay: false,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              IconsData.arrowBack,
              color: themeChange.darkTheme ? Colors.white : ColorsConst.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.blue,
              ),
              tooltip: 'Add to calendar',
              onPressed: () {
                Navigator.pop(context);
                Add2Calendar.addEvent2Cal(event).then((success) {
                  scaffoldMessengerKey.currentState.showSnackBar(
                      SnackBar(content: Text(success ? 'Success' : 'Error')));
                });
              }),
        ],
        backgroundColor: ColorsConst.white,
      ),
      body: EventDetail(
        eventLocation: widget.ticketLocation,
        eventAvailable: widget.ticketAvailable,
        eventDate: widget.ticketDate,
        eventDetail: widget.ticketDescription,
        eventPicture: widget.ticketImage,
        eventPrice: widget.ticketPrice,
        eventName: widget.ticketName,
      ),
    );
  }
}
