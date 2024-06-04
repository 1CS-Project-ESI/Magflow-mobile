// Remove unnecessary import if not using foreign functions

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _role = ''; // Initialize with an empty string
  int _id = 0; // Corrected data type
  String _token = '';
  
  String get role => _role;

  get structureId => null; // Getter for the role

  void setRole(String role) {
    _role = role;
    notifyListeners(); // Notify listeners of the change
  }

  int get id => _id;
  void setID(int id) {
    _id = id;
    notifyListeners(); // Notify listeners of the change
  }

  // String get token => _token;
  // void setToken(String token) {
  //   _token = token;
  //   notifyListeners(); // Notify listeners of the change
  // }

  // stay logged in
  // Future<void> saveUserCredentials() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('role', _role);
  //   await prefs.setInt('id', _id);
  // }

  // Future<void> loadUserCredentials() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _role = prefs.getString('role') ?? '';
  //   _id = prefs.getInt('id') ?? 0;
  //   notifyListeners();
  // }

  // // test if user instance exist ??

  bool _isLoggedIn = true; // Add this line

  bool get isLoggedIn => _isLoggedIn;

  Future<void> setLoggedIn(bool loggedIn) async {
    _isLoggedIn = loggedIn;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', loggedIn);
    notifyListeners();
  }

  // Future<void> loadUserData() async {
  //   await loadUserCredentials(); // Read stored credentials (including ID)
  //   notifyListeners();
  // }
}
