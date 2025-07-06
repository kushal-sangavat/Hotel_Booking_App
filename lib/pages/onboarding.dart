import 'package:flutter/material.dart';
import 'signup.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool owner = true, user = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              "images/bg.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 90.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Please select your role to grt started",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  owner
                      ? Material(
                        elevation: 6.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.black, width: 2.0)
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff67c0FB),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: Image.asset(
                                  "images/hotel.png",
                                  height: 45.5,
                                  width: 45.5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 15.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Looking for Guests?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    child: Text(
                                      "Easily find guests for your hotel.",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      : GestureDetector(
                        onTap: () {
                          setState(() {
                            owner = true;
                            user = false;
                          });
                        },
                        child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff67C0FB),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  child: Image.asset(
                                    "images/hotel.png",
                                    height: 44.6,
                                    width: 44.6,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Looking for Guests?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.8,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width /
                                          1.8,
                                      child: Text(
                                        "Easily find guests for your hotel.",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  SizedBox(height: 40.0),
                  user
                      ? Material(
                        elevation: 6.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.black, width: 2.0)
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xff67c0FB),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: Image.asset(
                                  "images/user.png",
                                  height: 45.5,
                                  width: 45.5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 15.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Looking for Hotels?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    child: Text(
                                      "Join our platform to find and book\nthe best hotels.",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      : GestureDetector(
                        onTap: () {
                          setState(() {
                            owner = false;
                            user = true;
                          });
                        },
                        child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xff67C0FB),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  child: Image.asset(
                                    "images/user.png",
                                    height: 44.6,
                                    width: 44.6,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 15.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Looking for Hotels?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.8,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width /
                                          1.8,
                                      child: Text(
                                        "Join our platform to find and book\nthe best hotels.",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(redirect: owner?"Owner":"User",)),);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 40.0),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xff432277),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
