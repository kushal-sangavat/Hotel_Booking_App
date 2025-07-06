import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/constant.dart';
import '../services/database.dart';
import '../services/shared_pref.dart';
import '../services/widget_support.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController moneycontroller = new TextEditingController();

  Map<String, dynamic>? paymentIntent;

  String? wallet, id;

  String getCurrentDateFormatted() {
    final now = DateTime.now();
    final day = DateFormat('dd').format(now);
    final month = DateFormat('MMM').format(now);
    return '$day\n$month';
  }

  getthesharedpref() async {
    wallet = await SharedpreferenceHelper().getUserWallet();
    id = await SharedpreferenceHelper().getUserId();
    transactionstream = await DatabaseMethods().getUserTransactions(id!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthesharedpref();
  }

  Stream? transactionstream;

  Widget allTransactions() {
    return StreamBuilder(
      stream: transactionstream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  margin: EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          ds["Date"],
                          textAlign: TextAlign.center,
                          style: AppWidget.boldwhitetextstyle(24.0),
                        ),
                      ),
                      SizedBox(width: 50.0),
                      Column(
                        children: [
                          Text(
                            "Amount Added :",
                            style: AppWidget.normaltextstyle(20.0),
                          ),
                          Text(
                            "\₹" + ds["Amount"],
                            style: AppWidget.headlinetextstyle(30.0),
                          ),
                        ],
                      ),
                    ],
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
      appBar: AppBar(
        title: Text("WALLET", style: AppWidget.headlinetextstyle(30.0)),
        centerTitle: true,
      ),
      body:
          wallet == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.all(10),

                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                              color: Color(0xFFececf8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/wallet.png",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 50.0),
                                Column(
                                  children: [
                                    Text(
                                      "Your Wallet",
                                      style: AppWidget.normaltextstyle(20.0),
                                    ),
                                    Text(
                                      "\₹" + wallet!,
                                      style: AppWidget.headlinetextstyle(34.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            moneycontroller.text = "50";
                            makePayment("50");
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "50",
                                style: AppWidget.boldwhitetextstyle(25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.0),
                        GestureDetector(
                          onTap: () {
                            moneycontroller.text = "100";
                            makePayment("100");
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "100",
                                style: AppWidget.boldwhitetextstyle(25),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 30.0),
                        GestureDetector(
                          onTap: () {
                            moneycontroller.text = "200";
                            makePayment("200");
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "200",
                                style: AppWidget.boldwhitetextstyle(25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        openBox();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Add Money",
                            style: AppWidget.boldwhitetextstyle(25),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "Your Transactions",
                              style: AppWidget.headlinetextstyle(20.0),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              height: MediaQuery.of(context).size.height / 2.5,
                              child: allTransactions(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent?['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Sangavat Hotel',
            ),
          )
          .then((value) {});
      displayPaymentSheet(amount);
    } catch (e, s) {
      print("exception: $e$s");
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            int updatedamount = int.parse(wallet!) + int.parse(amount);
            await DatabaseMethods().updateWallet(id!, updatedamount.toString());
            await SharedpreferenceHelper().saveUserWallet(
              updatedamount.toString(),
            );
            await getthesharedpref();
            String currentdate = getCurrentDateFormatted();
            Map<String, dynamic> addTransaction = {
              "Amount": moneycontroller.text,
              "Date": currentdate,
            };
            await DatabaseMethods().addUserTransaction(addTransaction, id!);
            setState(() {});

            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30.0,
                            ),
                            Text(
                              "Payment Successful",
                              style: AppWidget.headlinetextstyle(20.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            );
            paymentIntent = null;
          })
          .onError((error, stackTrace) {
            print("Error is:---> $error $stackTrace");
          });
    } on StripeException catch (e) {
      print("Error is:---> $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Cancelled")),
      );
    } catch (e) {
      print("Error is:---> $e");
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception('Failed to create payment intent: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  Future openBox() => showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    SizedBox(width: 50.0),
                    Text(
                      "Add Money",
                      style: TextStyle(
                        color: Color(0xff008080),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text("Enter amount"),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: moneycontroller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Money",
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    makePayment(moneycontroller.text);
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xff008080),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
