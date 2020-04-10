import 'package:flutter/material.dart';

/// Class to store colors used by the app
///
/// main usage of this class is to make sure that the whole ui
/// uses same chroma
class AppColors implements Colors {
  // App bar color
  static Color mainAppColor = Colors.blue[400];
  static Color backgroundColor = Colors.white;

  // Button Colors
  static Color mainButtonColor = Colors.blue[400];
  static Color buttonTextColor = Colors.white;
  static Color registerButtonEmailColor = Colors.blueGrey[700];
}