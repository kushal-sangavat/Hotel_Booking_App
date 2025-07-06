import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/database.dart';
import '../services/shared_pref.dart';
import '../services/widget_support.dart';

class OwnerHome extends StatefulWidget {
  const OwnerHome({super.key});

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  String? id, name;

  getonthesharedpref() async {
    id = await SharedpreferenceHelper().getUserId();
    name = await SharedpreferenceHelper().getUserName();

    print(id);
    setState(() {});
  }

  getontheload() async {
    await getonthesharedpref();
    bookingStream = await DatabaseMethods().getAdminbookings(id!);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Stream? bookingStream;

  Widget allAdminBookings() {
    return StreamBuilder(
      stream: bookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Center(child: Text("No bookings found"));
        }
        return snapshot.hasData
            ? ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                final format = DateFormat('dd, MM-yyyy');
                final date = format.parse(ds["CheckIn"]);
                final now = DateTime.now();

                return date.isBefore(now)
                    ? Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
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
                                  "images/boy.jpg",
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
                                        Icons.person,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        ds["Username"],
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                            3,
                                        child: Text(
                                          ds["CheckIn"] +
                                              " to " +
                                              ds["CheckOut"],
                                          style: AppWidget.normaltextstyle(
                                            19.0,
                                          ),
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
                                        style: AppWidget.headlinetextstyle(
                                          20.0,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Icon(
                                        Icons.currency_rupee,
                                        color: Colors.blue,
                                        size: 25.0,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        "\₹" + ds["Total"],
                                        style: AppWidget.headlinetextstyle(
                                          20.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    : Container();
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          name == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                child: Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        "images/home.jpg",
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(83, 0, 0, 0),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "images/wave.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Hello, " + name!,
                                style: AppWidget.boldwhitetextstyle(20.0),
                              ),
                            ],
                          ),
                          Text(
                            "Ready to Welcome\nyour next guest?",
                            style: AppWidget.whitetextstyle(24.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 5,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xFFececf8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          //SizedBox(height: 5.0),
                          Container(
                            height: MediaQuery.of(context).size.height / 1.4,
                            child: allAdminBookings(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
