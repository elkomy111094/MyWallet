// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../db_helper.dart';
import '../models/dept_model.dart';
import '../widgets/back_to_home.dart';
import 'home_screen.dart';

class AddDebt extends StatefulWidget {
  @override
  _AddDebtState createState() => _AddDebtState();
}

class _AddDebtState extends State<AddDebt> {
  DbHelper helper;

  String name, reason;
  int value;
  String date;
  GlobalKey<FormState> _myFormKey;

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper = DbHelper();
    _myFormKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: pColor,
        title: Text("New Debt"),
        centerTitle: true,
        leading: BackToHome(),
      ),
      body: ListView(
        children: [
          Form(
            key: _myFormKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val.length > 100) {
                                showToast("Name Is Too Long ");
                                return "The Name Should be Smaller Than 100 Letter";
                              } else if (val.length < 3 && val.length > 0) {
                                showToast("Name Is Too Short ");
                                return "The Name Should be Larger Than 3 Letter";
                              } else if (val == null || val == "") {
                                showToast("Please Enter Name Of Creditor");
                                return "Enter The Name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "creditor name...",
                              labelStyle: TextStyle(color: pColor),
                              hintText: "Enter creditor Name ...",
                              fillColor: pColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: pColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val.length > 1000) {
                                showToast("Reason Is Too Long ");
                                return "The Reason Should be Smaller Than 1000 Letter";
                              } else if (val.length < 10 && val.length > 0) {
                                showToast("Reason Is Too Short ");
                                return "The Reason Should be Larger Than 50 Letter";
                              } else if (val == null || val == "") {
                                showToast("Please Enter Reason Of debt");
                                return "Enter The Reason, please";
                              } else {
                                return null;
                              }
                            },
                            maxLines: 10,
                            decoration: InputDecoration(
                              labelText: "Reason Of Debt...",
                              labelStyle: TextStyle(color: pColor),
                              hintText: "Enter Debt Reason ...",
                              fillColor: pColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: pColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                reason = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            maxLength: 6,
                            validator: (val) {
                              if (val.length > 6) {
                                showToast("Value Is Too Long ");
                                return "The debt Should be Smaller Than 1000000 Letter";
                              } else if (val == "0") {
                                showToast("Debt value Should be Larger Than 0");
                                return "The debt Should be Larger Than 0 LE";
                              } else if (val == null || val == "") {
                                showToast("Please Enter The Debt Value  ");
                                return "Please Enter Value Of Debt  ";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Debt Value...",
                              labelStyle: TextStyle(color: pColor),
                              hintText: "Enter value of Debt...",
                              fillColor: pColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: pColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.white, width: 3),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            autocorrect: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            onChanged: (val) {
                              setState(() {
                                value = int.parse(val);
                              });
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2015, 1, 1),
                                    maxTime: DateTime(2025, 12, 30),
                                    onChanged: (date) {
                                  this.date = DateFormat("d/M/y")
                                      .format(date)
                                      .toString();
                                  print('change $date');
                                }, onConfirm: (date) {
                                  this.date = DateFormat("d / M /y")
                                      .format(date)
                                      .toString();
                                  print(this.date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border:
                                        Border.all(color: pColor, width: 5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Select Debt Date',
                                    style: TextStyle(
                                        color: pColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {
                          if (date == null) {
                            showToast("Please Choose Date oF Debt");
                          } else {
                            if (_myFormKey.currentState.validate() == true) {
                              Debt debt = Debt({
                                "name": name,
                                "reason": reason,
                                "value": value,
                                "date": this.date.toString(),
                              });
                              int id = await helper.addDebt(debt);
                              print(id);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => HomeScreen()));
                            }
                          }
                        },
                        color: pColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Add Debt",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
