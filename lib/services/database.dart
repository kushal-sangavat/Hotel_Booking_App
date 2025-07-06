import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addHotel(Map<String, dynamic> HotelInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .doc(id)
        .set(HotelInfoMap);
  }

  Future<Stream<QuerySnapshot>> getallHotels() async {
    return await FirebaseFirestore.instance.collection("Hotel").snapshots();
  }

  Future addUserBooking(
    Map<String, dynamic> userInfoMap,
    String id,
    String bookid,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .doc(bookid)
        .set(userInfoMap);
  }

  Future addHotelOwnerBooking(
    Map<String, dynamic> userInfoMap,
    String id,
    String bookid,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .doc(id)
        .collection("Booking")
        .doc(bookid)
        .set(userInfoMap);
  }

  Future addUserTransaction(
      Map<String, dynamic> userInfoMap,
      String id,
      ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Transaction")
        .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserbookings(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserTransactions(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Transaction")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserCityHotel(String city) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .where("HotelCity", isEqualTo: city.toLowerCase())
        .snapshots();
  }

  Future<QuerySnapshot> search(String updatedname) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .where("SearchKey", isEqualTo: updatedname.substring(0,1).toUpperCase())
        .get();
  }

  Future<Stream<QuerySnapshot>> getAdminbookings(String id) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .doc(id)
        .collection("Booking")
        .snapshots();
  }

  Future<QuerySnapshot> getUserbyemail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
  }

  Future updateWallet(String id, String walletamount) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).update({
      "Wallet": walletamount,
    });
  }
}
