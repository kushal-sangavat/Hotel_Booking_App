import 'package:flutter/material.dart';
import 'package:bookingapp/services/widget_support.dart';
import 'package:intl/intl.dart';


class DetailPage extends StatefulWidget {
  String name,price, wifi, hdtv, kitchen, bathroom, desc;
  DetailPage({
    required this.name,
    required this.price,
    required this.wifi,
    required this.hdtv,
    required this.kitchen,
    required this.bathroom,
    required this.desc,});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController guestcontroller = new TextEditingController();
  var finalamount;

  DateTime? startDate;
  DateTime? endDate;
  int daysDifference = 1;

  @override
  void initState() {
    super.initState();
    finalamount = int.parse(widget.price);}

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        startDate = picked;
        _calculateDifference();
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? (startDate ?? DateTime.now()).add(Duration(days: 1)),
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        endDate = picked;
        _calculateDifference();
      });
    }
  }

    void _calculateDifference() {
      if (startDate != null && endDate != null) {
          daysDifference = endDate!.difference(startDate!).inDays;
          finalamount = int.parse(widget.price);
          finalamount = finalamount! * daysDifference! * int.parse(guestcontroller.text);
          print(daysDifference);
      }
    }

    String _formatDate(DateTime? date) {
    return date != null ? DateFormat('dd, MM-yyyy').format(date) : "Select Date";
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      child: Image.asset(
                        "images/hotel1.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(top: 50.0, left: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Text(
                      widget.name,
                      style: AppWidget.headlinetextstyle(27.0),
                    ),
                    Text("\₹" + widget.price, style: AppWidget.normaltextstyle(27.0)),
                    Divider(thickness: 2.0),
                    SizedBox(height: 10.0),
                    Text(
                      "What this place offers",
                      style: AppWidget.headlinetextstyle(22.0),
                    ),
                    SizedBox(height: 10.0),
                    widget.wifi=="true"? Row(
                      children: [
                        Icon(
                          Icons.wifi,
                          color: const Color.fromARGB(255, 7, 102, 179),
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Free Wifi",
                          style: AppWidget.normaltextstyle(23.0),
                        ),
                      ],
                    ):Container(),
                    SizedBox(height: 20.0),
                    widget.hdtv=="true"? Row(
                      children: [
                        Icon(
                          Icons.tv,
                          color: const Color.fromARGB(255, 7, 102, 179),
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text("HDTV", style: AppWidget.normaltextstyle(23.0)),
                        SizedBox(width: 60.0),
                      ],
                    ):Container(),

                    SizedBox(height: 20.0),
                    widget.kitchen=="true"? Row(
                      children: [
                        Icon(
                          Icons.kitchen,
                          color: const Color.fromARGB(255, 7, 102, 179),
                          size: 30.0,
                        ),
                        SizedBox(width: 10.0),
                        Text("Kitchen", style: AppWidget.normaltextstyle(23.0)),
                      ],
                    ):Container(),
                    SizedBox(height: 20.0),
                    widget.bathroom=="true"? Row(
                      children: [
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
                        SizedBox(width: 60.0),
                      ],
                    ):Container(),
                    Divider(thickness: 2.0),
                    Text(
                      "About this place",
                      style: AppWidget.headlinetextstyle(22.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      widget.desc,
                      style: AppWidget.normaltextstyle(16.0),
                    ),
                    SizedBox(height: 20.0),
                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "\₹"+finalamount.toString()+" for "+daysDifference.toString()+" nights",
                              style: AppWidget.headlinetextstyle(22.0),
                            ),
                            SizedBox(height: 3.0),
                            Text(
                              "Check-in Date",
                              style: AppWidget.normaltextstyle(20.0),
                            ),
                            Divider(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    _selectStartDate(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  "${_formatDate(startDate)}",
                                  style: AppWidget.normaltextstyle(20.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.0),
                            Text(
                              "Check-out Date",
                              style: AppWidget.normaltextstyle(20.0),
                            ),
                            Divider(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    _selectEndDate(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  "${_formatDate(endDate)}",
                                  style: AppWidget.normaltextstyle(20.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Number of guests",
                              style: AppWidget.normaltextstyle(20),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              padding: EdgeInsets.only(left: 20.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFececf8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    finalamount = int.parse(widget.price);
                                    finalamount = finalamount * int.parse(value) * daysDifference;
                                  });
                                },
                                controller: guestcontroller,
                                style: AppWidget.headlinetextstyle(20.0),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "1",
                                  hintStyle: TextStyle(
                                    color: const Color.fromARGB(120, 0, 0, 0),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(15)),
                              child: Center(child: Text("Book Now",style: AppWidget.whitetextstyle(20.0),)),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
