// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:x_wallet/models/dept_model.dart';

import '../constants.dart';
import '../db_helper.dart';
import '../widgets/back_to_home.dart';
import 'home_screen.dart';

class UpdateDebt extends StatefulWidget {
  Debt debt;

  @override
  _UpdateDebtState createState() => _UpdateDebtState();

  UpdateDebt(Debt theDebt) {
    this.debt = theDebt;
  }
}

class _UpdateDebtState extends State<UpdateDebt> {
  DbHelper helper;
  String date;
  TextEditingController tName;
  TextEditingController tVal;
  TextEditingController tReason;
  final _myFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper = DbHelper();

    tName = TextEditingController();
    tVal = TextEditingController();
    tReason = TextEditingController();

    tName.text = widget.debt.name;
    tVal.text = (widget.debt.value).toString();
    tReason.text = widget.debt.reason;
    date = widget.debt.date;
  }

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tName.clear();
    tReason.clear();
    tVal.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pColor,
        title: Text("Update Debts"),
        centerTitle: true,
        leading: BackToHome(),
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
            ),
          ),
          Form(
            key: _myFormKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val.length > 100) {
                        showToast("Name Is Too Long ");
                        return "The Name Should be Smaller Than 100 Letter";
                      } else if (val.length < 3) {
                        showToast("Name Is Too Short ");
                        return "The Name Should be Larger Than 3 Letter";
                      } else if (val == null) {
                        showToast("Please Enter Name Of Creditor");
                        return "Enter The Name";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 1,
                    maxLength: 100,
                    controller: tName,
                    decoration: InputDecoration(
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
                        borderSide:
                            new BorderSide(color: Colors.white, width: 3),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    onSaved: (value) {
                      tName.text = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.length > 1000) {
                        showToast("Reason Is Too Long ");
                        return "The Reason Should be Smaller Than 1000 Letter";
                      } else if (val.length < 50) {
                        showToast("Reason Is Too Short ");
                        return "The Reason Should be Larger Than 50 Letter";
                      } else if (val == null) {
                        showToast("Please Reason Of debt");
                        return "Enter The Reason, please";
                      } else {
                        return null;
                      }
                    },
                    controller: tReason,
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: "Reason Of Due...",
                      labelStyle: TextStyle(color: pColor),
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
                        borderSide:
                            new BorderSide(color: Colors.white, width: 3),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    onSaved: (value) {
                      tReason.text = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val.length > 10) {
                        showToast("Name Is Too Long ");
                        return "The debt Should be Smaller Than 10000000000 Letter";
                      } else if (val.length <= 0) {
                        showToast("No Debt value");
                        return "The debt Should be Larger Than 0 LE";
                      } else if (val == null) {
                        showToast("Please The Debt Value  ");
                        return "Please Enter Value Of Debt  ";
                      } else {
                        return null;
                      }
                    },
                    controller: tVal,
                    decoration: InputDecoration(
                      labelText: "Due Value...",
                      labelStyle: TextStyle(color: pColor),
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
                        borderSide:
                            new BorderSide(color: Colors.white, width: 3),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    onSaved: (value) {
                      tVal.text = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2015, 1, 1),
                            maxTime: DateTime(2025, 12, 30), onChanged: (date) {
                          this.date =
                              DateFormat("y/M/d").format(date).toString();
                          print('change $date');
                        }, onConfirm: (date) {
                          this.date =
                              DateFormat("d / M /y").format(date).toString();
                          print(this.date);
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: pColor, width: 2)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Select Debt Date',
                            style: TextStyle(
                              color: pColor,
                            ),
                          ),
                        ),
                      )),
                  RaisedButton(
                    onPressed: () async {
                      if (_myFormKey.currentState.validate()) {
                        Debt debt = Debt({
                          "id": widget.debt.id,
                          "name": tName.text,
                          "reason": tReason.text,
                          "value": int.parse(tVal.text),
                          "date": date,
                        });
                        await helper.updateDebt(debt);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (ctx) => HomeScreen()));
                      } else {
                        showToast("Updating Failed");
                      }
                    },
                    color: pColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "UpDate Debt",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
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
