import 'package:flutter/material.dart';
import 'package:bookingapp/services/widget_support.dart';
import 'signup.dart';
import 'bottomnav.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnav()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "No user found for that Email",
                style: TextStyle(fontSize: 18.0,color: Colors.black),
              ),
            ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Wrong Password Provided",
                style: TextStyle(fontSize: 18.0,color: Colors.black),
              ),
            ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Image.asset("images/login.png"),
            SizedBox(height: 5.0),
            Center(
              child: Text("LogIn", style: AppWidget.headlinetextstyle(25.0)),
            ),
            SizedBox(height: 5.0),
            Center(
              child: Text(
                "Please enter the detail to continue",
                style: AppWidget.normaltextstyle(17.0),
              ),
            ),
            SizedBox(height: 20.0),

            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("Email", style: AppWidget.normaltextstyle(20.0)),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: mailcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.mail, color: Color(0xFF0D3DD6)),
                  hintText: "Enter Email",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(130, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text("Password", style: AppWidget.normaltextstyle(20.0)),
            ),
            SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0),
              decoration: BoxDecoration(
                color: Color(0xFFececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                obscureText: true,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.password, color: Color(0xFF0D3DD6)),
                  hintText: "Enter Password",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(130, 0, 0, 0),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(right: 20.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                Text("Forgot Password ?",style: AppWidget.normaltextstyle(18.0),),
              ],),
            ),
            SizedBox(height: 30.0),
            GestureDetector(
              onTap: () {
                if (mailcontroller.text != "" && passwordcontroller.text != "") {
                  setState(() {
                    email = mailcontroller.text;
                    password = passwordcontroller.text;
                  });
                  userLogin();
                }
              },
              child: Center(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF1C74E3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Text(
                      "LogIn",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: AppWidget.normaltextstyle(18.0),),
                  Text(" SignUp",style: AppWidget.headlinetextstyle(18.0),),
                ],),
            ),
          ],),
        ),
      ),
    );
  }
}
