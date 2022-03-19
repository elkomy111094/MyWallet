// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../constants.dart';
import '../db_helper.dart';
import '../widgets/debts_view.dart';
import '../widgets/dues_view.dart';
import 'add_debt_screen.dart';
import 'add_due_screen.dart';

class HomeScreen extends StatefulWidget {
  static String getFirstName(String completeName) {
    if (completeName.contains(" ")) {
      int indxesNumberOfFirstName = completeName.indexOf(" ");
      String firstName = completeName.substring(0, indxesNumberOfFirstName);
      return firstName;
    }
    return completeName;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool duesTaped = true; //to start to in first build with it
  bool debtsTaped = false;

  int totalDebts = 0; //sum of my total debts
  int totalDues = 0; //sum of my total dues
  int total = 0; //all dues - all debts

  DbHelper helper; //instance to reach all database functions and vars

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper = DbHelper(); //to initiate as instance of database class
  }

  @override
  Widget build(BuildContext context) {
    total = totalDues - totalDebts;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: pColor, width: 2),
                ),
                child: FloatingActionButton(
                  backgroundColor: pColor,
                  mini: true,
                  onPressed: () {
                    if (debtsTaped) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => AddDebt()));
                    } else {
                      //dues is tabed
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => AddDue()));
                    }
                  },
                  child: Icon(Icons.add),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  /*borderRadius: BorderRadius.circular(25),*/
                  border: Border.all(color: pColor, width: 3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    duesTaped ? "Due" : "Debt",
                    style:
                        TextStyle(color: pColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.white70,
            unselectedLabelStyle: TextStyle(fontSize: 14),
            onTap: (val) {
              if (val == 0) //value will be 0 to view dues or 1 to view debts
              {
                setState(() {
                  duesTaped = true;
                  debtsTaped = false;
                });
              } else {
                setState(() {
                  duesTaped = false;
                  debtsTaped = true;
                });
              }

              print(duesTaped);
              print(debtsTaped);
            },
            tabs: [
              Tab(
                icon: Image.asset(
                  "assets/images/dues.png",
                  height: 40,
                  width: 40,
                  color: duesTaped == true ? Colors.white : Colors.white70,
                ),
                text: "My Dues",
              ),
              Tab(
                icon: Image.asset(
                  "assets/images/depts.png",
                  height: 40,
                  width: 40,
                  color: debtsTaped == true ? Colors.white : Colors.white70,
                ),
                text: "My Debts",
              ),
            ],
          ),
          backgroundColor: pColor,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TabBarView(
                    children: [
                      // represent the dues tab
                      //--------------------------------------------------------
                      DuesView(helper),
                      // represent the debts tab
                      //--------------------------------------------------------

                      DebtsView(helper),
                    ],
                  ),
                ),
                //represent the footer of the main page
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: pColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Dues",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FutureBuilder(
                                future: helper.calculateTotalDues(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  totalDues = snapshot.data[0]["total"]
                                      ? snapshot.data[0]["total"] != null
                                      : 0;
                                  print("totalDues is = $totalDues");
                                  return snapshot.hasData
                                      ? Text(
                                          (snapshot.data[0]["total"] == 0)
                                              ? "0"
                                              : snapshot.data[0]["total"]
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : SizedBox();
                                })
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 2,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: FutureBuilder(
                                future: helper.calTotal(),
                                builder: (ctx, AsyncSnapshot snapShot) {
                                  return !snapShot.hasData
                                      ? SizedBox()
                                      : Text(
                                          snapShot.data != 0
                                              ? snapShot.data.toString()
                                              : "0",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: pColor,
                                              fontWeight: FontWeight.bold),
                                        );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 2,
                          color: Colors.white,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Debts",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FutureBuilder(
                                future: helper.calculateTotalDebts(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  totalDebts = snapshot.data[0]["total"]
                                      ? snapshot.data[0]["total"]
                                      : 0;
                                  print("totalDebts is = $totalDebts");
                                  return snapshot.hasData
                                      ? Text(
                                          ((snapshot.data[0]["total"] ==
                                                      null) ||
                                                  (snapshot.data[0]["total"]) ==
                                                      0)
                                              ? "0"
                                              : snapshot.data[0]["total"]
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : SizedBox();
                                })
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
