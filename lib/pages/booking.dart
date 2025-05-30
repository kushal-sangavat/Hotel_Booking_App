import 'package:flutter/material.dart';
import '../services/database.dart';
import '../services/shared_pref.dart';
import '../services/widget_support.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? id;

  Stream? bookingStream;

  getontheload() async {
    id = await SharedpreferenceHelper().getUserId();
    bookingStream = await DatabaseMethods().getUserbookings(id!);
    setState(() {

    });
  }


  @override
  void initState() {
    super.initState();
    getontheload();
  }



  bool incoming = true, past = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 70) / 2; // 20 + 30 + 20 padding/margin

    return Scaffold(
      appBar: AppBar(
        title: Text("BOOKING", style: AppWidget.headlinetextstyle(30.0)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  incoming
                      ? Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: cardWidth,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(18, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/incoming.png",
                            height: 121.5,
                            width: 121.5,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Incoming\nBookings",
                            textAlign: TextAlign.center,
                            style: AppWidget.headlinetextstyle(30.0),
                          ),
                        ],
                      ),
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      setState(() {
                        incoming = true;
                        past = false;
                      });
                    },
                    child: Container(
                      width: cardWidth,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(18, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/incoming.png",
                            height: 118.5,
                            width: 118.5,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Incoming\nBookings",
                            textAlign: TextAlign.center,
                            style: AppWidget.normaltextstyle(30.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 30.0),
                  past
                      ? Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: cardWidth,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(18, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/past.png",
                            height: 121.5,
                            width: 121.5,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Past\nBookings",
                            textAlign: TextAlign.center,
                            style: AppWidget.headlinetextstyle(30.0),
                          ),
                        ],
                      ),
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      setState(() {
                        incoming = false;
                        past = true;
                      });
                    },
                    child: Container(
                      width: cardWidth,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(18, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            "images/past.png",
                            height: 118.5,
                            width: 118.5,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            "Past\nBookings",
                            textAlign: TextAlign.center,
                            style: AppWidget.normaltextstyle(30.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
