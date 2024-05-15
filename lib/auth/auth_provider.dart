import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String _role = ''; // Initialize with an empty string

  String get role => _role; // Getter for the role

  void setRole(String role) {
    _role = role;
    notifyListeners(); // Notify listeners of the change
  }
}
