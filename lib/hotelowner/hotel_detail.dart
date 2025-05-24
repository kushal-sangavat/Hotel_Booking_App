import 'package:flutter/material.dart';
import 'package:bookingapp/services/widget_support.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  bool isChecked = false,
      isChecked1 = false,
      isChecked2 = false,
      isChecked3 = false;

  TextEditingController hotelnamecontroller = new TextEditingController();
  TextEditingController hotelchargescontroller = new TextEditingController();
  TextEditingController hoteladdresscontroller = new TextEditingController();
  TextEditingController hoteldesccontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hotel Detail", style: AppWidget.boldwhitetextstyle(26.0)),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(width: 2.0, color: Colors.black),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 40.0,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text("Hotel Name", style: AppWidget.normaltextstyle(20.0)),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Hotel Name",
                            hintStyle: AppWidget.normaltextstyle(18.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Hotel Room Charges",
                        style: AppWidget.normaltextstyle(20.0),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Room Charges",
                            hintStyle: AppWidget.normaltextstyle(18.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Hotel Address",
                        style: AppWidget.normaltextstyle(20.0),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Hotel Address",
                            hintStyle: AppWidget.normaltextstyle(18.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "What Service you want to offer?",
                        style: AppWidget.normaltextstyle(20.0),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Icon(
                            Icons.wifi,
                            color: const Color.fromARGB(255, 7, 102, 179),
                            size: 30.0,
                          ),
                          SizedBox(width: 10.0),
                          Text("Wifi", style: AppWidget.normaltextstyle(23.0)),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: isChecked1,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked1 = value!;
                              });
                            },
                          ),
                          Icon(
                            Icons.tv,
                            color: const Color.fromARGB(255, 7, 102, 179),
                            size: 30.0,
                          ),
                          SizedBox(width: 10.0),
                          Text("HDTV", style: AppWidget.normaltextstyle(23.0)),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: isChecked2,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked2 = value!;
                              });
                            },
                          ),
                          Icon(
                            Icons.kitchen,
                            color: const Color.fromARGB(255, 7, 102, 179),
                            size: 30.0,
                          ),
                          SizedBox(width: 10.0),
                          Text("Kitchen", style: AppWidget.normaltextstyle(23.0)),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: isChecked3,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked3 = value!;
                              });
                            },
                          ),
                          Icon(
                            Icons.bathroom,
                            color: const Color.fromARGB(255, 7, 102, 179),
                            size: 30.0,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "Bathroom",
                            style: AppWidget.normaltextstyle(23.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Hotel Description",
                        style: AppWidget.normaltextstyle(20.0),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextField(
                          maxLines: 6,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Description about your Hotel",
                            hintStyle: AppWidget.normaltextstyle(18.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10.0),),
                          width: MediaQuery.of(context).size.width/1.5,
                          child: Center(child: Text("Submit", style: AppWidget.boldwhitetextstyle(26.0),)),
                        ),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
