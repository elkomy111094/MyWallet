// @dart=2.9
import "package:flutter/material.dart";
import 'package:x_wallet/screens/home_screen.dart';

void main() {
  runApp(MyWallet());
}

class MyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
