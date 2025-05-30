import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allUserBookings() {
    return StreamBuilder(
      stream: bookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(

              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                final format = DateFormat('dd, MMM yyyy');
                final date = format.parse(ds["CheckIn"]);
                final now = DateTime.now();

                return date.isBefore(now) && past? Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Material(
                    elevation: 1.5,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(18, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.asset(
                              "images/hotel1.jpg",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.hotel,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    ds["HotelName"],
                                    style: AppWidget.normaltextstyle(20.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      ds["CheckIn"] + " to " + ds["CheckOut"],
                                      style: AppWidget.normaltextstyle(19.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.group,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    ds["Guests"],
                                    style: AppWidget.headlinetextstyle(20.0),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Colors.blue,
                                    size: 25.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    "\₹"+ds["Total"],
                                    style: AppWidget.headlinetextstyle(20.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ): date.isAfter(now) && incoming? Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Material(
                    elevation: 1.5,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(18, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.asset(
                              "images/hotel1.jpg",
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.hotel,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    ds["HotelName"],
                                    style: AppWidget.normaltextstyle(20.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      ds["CheckIn"] + " to " + ds["CheckOut"],
                                      style: AppWidget.normaltextstyle(19.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.group,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    ds["Guests"],
                                    style: AppWidget.headlinetextstyle(20.0),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(
                                    Icons.currency_rupee,
                                    color: Colors.blue,
                                    size: 25.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    "\₹"+ds["Total"],
                                    style: AppWidget.headlinetextstyle(20.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ): Container();
              },
            )
            : Container();
      },
    );
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
              SizedBox(height: 30.0),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: allUserBookings(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
