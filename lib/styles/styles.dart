import 'package:flutter/material.dart';


class AppColors {
  static const Color primaryColor = Colors.green;
  static const Color secondaryColor = Colors.grey;
  static const Color backgroundColor = Color.fromARGB(255, 10, 10, 10);
  static const Color cardColor = Color.fromARGB(150, 10, 10, 10);
  static const Color textColor = Colors.white;
  static const Color hintColor = Colors.grey;
}

class AppStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16.0,
    color: AppColors.hintColor,
  );

  static const TextStyle inputTextStyle = TextStyle(
    color: AppColors.textColor,
  );

  static const InputDecoration inputDecoration = InputDecoration(
    labelStyle: TextStyle(color: AppColors.hintColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondaryColor),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );

  static const ButtonStyle buttonStyle = ButtonStyle(
    padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 15.0)),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
    backgroundColor: WidgetStatePropertyAll<Color>(AppColors.primaryColor),
    foregroundColor: WidgetStatePropertyAll<Color>(AppColors.textColor),
  );
}