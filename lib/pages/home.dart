import '../services/widget_support.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'city_hotel.dart';
import 'detail_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? hotelStream;

  getontheload() async {
    hotelStream = await DatabaseMethods().getallHotels();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
    getCityCounts();
  }

  bool search = false;
  var queryResultSet = [];
  var tempSearchStore = [];
  TextEditingController searchcontroller = new TextEditingController();

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      search = true;
    });

    var CapitalizedValue = value.substring(0,1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element["UpdatedName"].startWith(CapitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  int? mumbaicount, newyorkcount, balicount, dubaicount;

  Future<void> getCityCounts() async {
    final firestore = FirebaseFirestore.instance;

    final mumbaiQuerySnapshot = await firestore
    .collection('Hotel')
    .where('HotelCity', isEqualTo: 'mumbai')
    .get();

    mumbaicount = mumbaiQuerySnapshot.docs.length;

    final newyorkQuerySnapshot = await firestore
    .collection('Hotel')
    .where('HotelCity', isEqualTo: 'new york')
    .get();

    newyorkcount = newyorkQuerySnapshot.docs.length;

    final baliQuerySnapshot = await firestore
    .collection('Hotel')
    .where('HotelCity', isEqualTo: 'bali')
    .get();

    balicount = baliQuerySnapshot.docs.length;

    final dubaiQuerySnapshot = await firestore
    .collection('Hotel')
    .where('HotelCity', isEqualTo: 'dubai')
    .get();

    dubaicount = dubaiQuerySnapshot.docs.length;

    setState(() {});
  }

  Widget allHotels() {
    return StreamBuilder(
      stream: hotelStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetailPage(
                              name: ds["HotelName"],
                              price: ds["HotelCharges"],
                              desc: ds["HotelDescription"],
                              wifi: ds["WiFi"],
                              hdtv: ds["HDTV"],
                              kitchen: ds["Kitchen"],
                              bathroom: ds["Bathroom"],
                              hotelid: ds.id,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
                    child: Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                ds["Image"],
                                width: MediaQuery.of(context).size.width / 1.2,
                                fit: BoxFit.cover,
                                height: 230,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 5.0),
                                  Text(
                                    ds["HotelName"],
                                    style: AppWidget.normaltextstyle(22.0),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.4,
                                  ),
                                  Text(
                                    "\₹" + ds["HotelCharges"],
                                    style: AppWidget.normaltextstyle(22.0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    ds["HotelAddress"],
                                    style: AppWidget.normaltextstyle(18.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    child: Image.asset(
                      "images/home.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: 265,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 40.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 265,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(97, 0, 0, 0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.white),
                            SizedBox(width: 10.0),
                            Text(
                              "India, Delhi",
                              style: AppWidget.whitetextstyle(20.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "Hey, Kushal! Tell us where you want to go",
                          style: AppWidget.whitetextstyle(24.0),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                          margin: EdgeInsets.only(top: 20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(103, 255, 255, 255),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintText: "Search Places",
                              hintStyle: TextStyle(
                                color: const Color.fromARGB(190, 255, 255, 255),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "The most relevant",
                  style: AppWidget.headlinetextstyle(22.0),
                ),
              ),
              SizedBox(height: 20.0),
              Container(height: 330, child: allHotels()),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Discover new Places",
                  style: AppWidget.headlinetextstyle(22.0),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                height: 280,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityHotel(city: "Mumbai"),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Material(
                          elevation: 2.5,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    "images/mumbai.jpg",
                                    height: 200,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Mumbai",
                                    style: AppWidget.headlinetextstyle(20.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.hotel,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        mumbaicount.toString() + " Hotels",
                                        style: AppWidget.normaltextstyle(18.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityHotel(city: "New York"),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
                        child: Material(
                          elevation: 2.5,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    "images/newyork.jpg",
                                    height: 200,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "New York",
                                    style: AppWidget.headlinetextstyle(20.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.hotel,
                                        color: Colors.blue,
                                        size: 30.0,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        newyorkcount.toString() + " Hotels",
                                        style: AppWidget.normaltextstyle(18.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child: Material(
                        elevation: 2.5,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  "images/bali.jpg",
                                  height: 200,
                                  width: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Bali",
                                  style: AppWidget.headlinetextstyle(20.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.hotel,
                                      color: Colors.blue,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      balicount.toString() + " Hotels",
                                      style: AppWidget.normaltextstyle(18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child: Material(
                        elevation: 2.5,
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  "images/dubai.jpg",
                                  height: 200,
                                  width: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "Dubai",
                                  style: AppWidget.headlinetextstyle(20.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.hotel,
                                      color: Colors.blue,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      dubaicount.toString() + " Hotels",
                                      style: AppWidget.normaltextstyle(18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
