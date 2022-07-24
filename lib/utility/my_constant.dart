import 'package:flutter/material.dart';

class MyConstant {
  //field
  static Color primary = Color.fromARGB(255, 164, 52, 228);
  static Color dark = const Color.fromARGB(255, 38, 2, 41);
  static Color light = Color.fromARGB(255, 197, 137, 225);
  static Color active = const Color.fromARGB(255, 19, 107, 180);

  //method

  BoxDecoration bgMainBox() {
    return BoxDecoration(
      gradient: RadialGradient(center: Alignment(-0.3, -0.3),
        radius: 1.0,
        colors: <Color>[Colors.white, MyConstant.primary],
      ),
    );
  }

  TextStyle h1Style() {
    return TextStyle(
      fontSize: 48,
      color: dark,
      fontWeight: FontWeight.w700,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 24,
      color: dark,
      fontWeight: FontWeight.w500,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 20,
      color: dark,
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3WhiteStyle() {
    return const TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3lightStyle() {
    return TextStyle(
      fontSize: 20,
      color: light,
      fontWeight: FontWeight.normal,
      fontFamily: 'Kanit',
    );
  }

  TextStyle h3ActiveStyle() {
    return TextStyle(
      fontSize: 22,
      color: active,
      fontWeight: FontWeight.w500,
      fontFamily: 'Kanit',
    );
  }
}
