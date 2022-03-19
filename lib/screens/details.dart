// @dart=2.9

import 'package:flutter/material.dart';

import '../constants.dart';

class Details extends StatelessWidget {
  final String name;
  final String reason;
  final int Value;
  final String date;

  Details(
    this.name,
    this.reason,
    this.Value,
    this.date,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pColor,
        centerTitle: true,
        title: Text(
          name,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "$Value LE",
                  style: TextStyle(
                      color: pColor, fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  date,
                  style: TextStyle(
                      color: pColor, fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Card(
              color: pColor,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  reason,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
