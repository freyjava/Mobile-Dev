// lib/config/app_config.dart
import 'package:flutter/material.dart';

class AppConfig {
  // App Information
  static const String appTitle = 'Class Manager';
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardMarginHorizontal = 16.0;
  static const double cardMarginVertical = 4.0;
  static const double iconSize = 64.0;
  static const int snackBarDuration = 3;
  
  // Search Configuration
  static const String searchHint = 'Search students...';
  
  // Empty State Messages
  static const String noStudentsMessage = 'No students found\nTap + to add your first student';
  static const String noSearchResultsMessage = 'No students match your search';
  
  // Gender Options
  static const List<String> genderOptions = ['Male', 'Female', 'Other'];
  
  // Form Field Spacing
  static const double formFieldSpacing = 16.0;
  
  // Colors
  static const Color successColor = Colors.green;
  static const Color errorColor = Colors.red;
  static const Color presentColor = Colors.green;
  static const Color absentColor = Colors.red;
  
  // Text Styles
  static const TextStyle cardTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle emptyStateTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey[600],
  );
  
  static const TextStyle whiteTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  
  // Messages
  static String getAttendanceMessage(String name, bool isPresent) {
    return '$name marked as ${isPresent ? "present" : "absent"}';
  }
  
  static String getDeleteSuccessMessage(String name) {
    return '$name deleted successfully';
  }
  
  static String getAddSuccessMessage(String name) {
    return '$name added successfully';
  }
  
  static String getUpdateSuccessMessage(String name) {
    return '$name updated successfully';
  }
  
  static String getDeleteConfirmMessage(String name) {
    return 'Are you sure you want to delete $name?';
  }
}