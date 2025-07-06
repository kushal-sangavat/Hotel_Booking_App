import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferenceHelper {
  static String userNameKey = "USERNAMEKEY";
  static String userIdKey = "USERIDKEY";
  static String userImageKey = "USERIMAGEKEY";
  static String userEmailKey = "USEREMAILKEY";
  static String userWalletKey = "USERWALLETKEY";

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String?> getUserImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String?> getUserWallet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userWalletKey);
  }

  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, name);
  }

  Future<void> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, id);
  }

  Future<void> saveUserImage(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userImageKey, imageUrl);
  }

  Future<void> saveUserEmail(String email) async { // ✅ Saver for email
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userEmailKey, email);
  }

  Future<void> saveUserWallet(String wallet) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userWalletKey, wallet);
  }
}
