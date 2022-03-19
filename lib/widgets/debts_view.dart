// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../db_helper.dart';
import '../models/dept_model.dart';
import '../screens/details.dart';
import '../screens/home_screen.dart';
import '../screens/updateDebt.dart';

class DebtsView extends StatefulWidget {
  final DbHelper helper;
  DebtsView(this.helper);

  @override
  _DebtsViewState createState() => _DebtsViewState();
}

class _DebtsViewState extends State<DebtsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: FutureBuilder(
          future: widget.helper.allDebts(),
          builder: (context, AsyncSnapshot snapShots) {
            return !snapShots.hasData
                ? Center(
                    child: Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: snapShots.data.length,
                    itemBuilder: (context, index) {
                      Debt debt = Debt.fromMap(snapShots.data[index]);

                      print(debt.date);

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return Details(debt.name, debt.reason,
                                    debt.value, debt.date);
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black45,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: pColor, width: 5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: pColor, width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: pColor),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  "${HomeScreen.getFirstName(debt.name)}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: pColor, width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: pColor),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  "${debt.value} LE",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: pColor, width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: pColor),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  debt.date == null
                                                      ? DateFormat("y/M/d")
                                                          .format(
                                                              DateTime.now())
                                                          .toString()
                                                      : debt.date,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25),
                                    child: Card(
                                      color: Colors.white70,
                                      elevation: 25,
                                      shadowColor: pColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0, top: 10),
                                                  child: Text(
                                                    "${debt.reason}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    maxLines: 3,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25.0),
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 25,
                                                    ),
                                                    onPressed: () {
                                                      AlertDialog DeleteAlert =
                                                          AlertDialog(
                                                        title: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                              size: 35,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              "Deleting Debt",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        content: Container(
                                                          height: 75,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  "Are You Sure ?"),
                                                              Text(
                                                                  "${debt.name} Debt Will Be Deleted")
                                                            ],
                                                          ),
                                                        ),
                                                        elevation: 10,
                                                        actions: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  int num = await widget
                                                                      .helper
                                                                      .deleteDebt(
                                                                          debt.id);
                                                                  setState(
                                                                      () {});
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushReplacement(MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return HomeScreen();
                                                                  }));
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 10,
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            25,
                                                                        right:
                                                                            25),
                                                                    child: Text(
                                                                        "OK"),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child: Text(
                                                                        "CanCel"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      );
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return DeleteAlert;
                                                          });
                                                    },
                                                  ),
                                                  elevation: 5,
                                                ),
                                                Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0)),
                                                  elevation: 5,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Colors.green,
                                                      size: 25,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                        return UpdateDebt(debt);
                                                      }));
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                        ],
                      );
                    });
          }),
    );
  }
}
