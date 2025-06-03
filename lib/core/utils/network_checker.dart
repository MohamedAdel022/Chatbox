import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';

class NetworkChecker {
  static Future<bool> hasConnection() async {
    try {
      // Try to connect to a reliable DNS server
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('Internet connection is available');
        return true;
      }
    } on SocketException catch (e) {
      log('Socket exception while checking connectivity: $e');
      return false;
    }
    
    log('Failed to verify internet connection');
    return false;
  }
  
  // A simple widget to test Firebase connectivity
  static Future<bool> testFirebaseConnectivity() async {
    bool hasInternet = await hasConnection();
    if (!hasInternet) {
      return false;
    }
    
    try {
      // Simple DNS lookup to firestore.googleapis.com
      final result = await InternetAddress.lookup('firestore.googleapis.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      log('Error connecting to Firebase: $e');
      return false;
    }
    
    return false;
  }
  
  // Helper method to show connection status with proper context handling
  static void showConnectionStatus(BuildContext context, {required bool connected, String? errorMessage}) {
    if (!connected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? 'No internet connection detected. Please check your network settings.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully connected to Firebase servers!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
