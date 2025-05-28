import 'package:bookingapp/hotelowner/owner_home.dart';
import 'package:flutter/material.dart';
import '../services/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:random_string/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/database.dart';

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

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  TextEditingController hotelnamecontroller = new TextEditingController();
  TextEditingController hotelchargescontroller = new TextEditingController();
  TextEditingController hoteladdresscontroller = new TextEditingController();
  TextEditingController hoteldesccontroller = new TextEditingController();

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

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
                      selectedImage != null
                          ? Center(
                            child: Container(
                              height: 200,
                              width: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                          : GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Center(
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                    width: 2.0,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                      SizedBox(height: 20.0),
                      Text(
                        "Hotel Name",
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
                          controller: hotelnamecontroller,
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
                          controller: hotelchargescontroller,
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
                          controller: hoteladdresscontroller,
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
                          Text("WiFi", style: AppWidget.normaltextstyle(23.0)),
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
                          Text(
                            "Kitchen",
                            style: AppWidget.normaltextstyle(23.0),
                          ),
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
                          controller: hoteldesccontroller,
                          maxLines: 6,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Description about your Hotel",
                            hintStyle: AppWidget.normaltextstyle(18.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () async {
                          String addId = randomAlphaNumeric(10);

                          // Reference fitrebaseStorageRef = FirebaseStorage
                          //     .instance
                          //     .ref()
                          //     .child("bloglImages")
                          //     .child(addId);
                          // final UploadTask Task = fitrebaseStorageRef.putFile(
                          //   selectedImage!,
                          // );
                          // var downloadUrl =
                          //     await (await Task).ref.getDownloadURL();

                          Map<String, dynamic> addHotel = {
                            "Image": "",
                            "HotelName": hotelnamecontroller.text,
                            "HotelCharges": hotelchargescontroller.text,
                            "HotelAddress": hoteladdresscontroller.text,
                            "HotelDescription": hoteldesccontroller.text,
                            "WiFi": isChecked ? "true" : "false",
                            "HDTV": isChecked1 ? "true" : "false",
                            "Kitchen": isChecked2 ? "true" : "false",
                            "Bathroom": isChecked3 ? "true" : "false",
                            "id": addId,
                          };
                          await DatabaseMethods().addHotel(addHotel, addId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Hotel Details has been uploaded Successfully!",
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OwnerHome(),
                            ),
                          );
                        },
                        child: Center(
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Center(
                              child: Text(
                                "Submit",
                                style: AppWidget.boldwhitetextstyle(26.0),
                              ),
                            ),
                          ),
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
