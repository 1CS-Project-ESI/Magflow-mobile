// Remove unnecessary import if not using foreign functions

import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String _role = ''; // Initialize with an empty string
  int _id = 0; // Corrected data type

  String get role => _role; // Getter for the role
  
  void setRole(String role) {
    _role = role;
    notifyListeners(); // Notify listeners of the change
  }
  int get id => _id;
  void setID(int id) {
    _id = id;
    notifyListeners(); // Notify listeners of the change
  }
}
