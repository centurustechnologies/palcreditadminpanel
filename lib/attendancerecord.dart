import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Attendance extends StatefulWidget {
  final String ids;
  const Attendance({
    super.key,
    required this.ids,
  });

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('agents');
  TextEditingController searchcontroller = TextEditingController();
  String search = '';

  Future updateattendance(String id) async {
    await FirebaseFirestore.instance
        .collection('agents')
        .doc(widget.ids)
        .collection('attendance')
        .doc(id)
        .update({'status': 'Absent'});
  }

  Future updateattendanceagain(String id) async {
    await FirebaseFirestore.instance
        .collection('agents')
        .doc(widget.ids)
        .collection('attendance')
        .doc(id)
        .update({'status': 'Present'});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: mobileView(context),
      tablet: mobileView(context),
      desktop: desktopView(context),
    );
  }

  desktopView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 5, 66, 116),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 102, 100, 100)
                                  .withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 49,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 5, 66, 116),
                                  Color.fromARGB(255, 0, 90, 163)
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Center(
                                child: Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          width: 220,
                          height: 45,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: TextField(
                                controller: searchcontroller,
                                onChanged: (value) {
                                  setState(() {
                                    search = searchcontroller.text;
                                  });
                                },
                                onEditingComplete: () {
                                  setState(() {
                                    search = searchcontroller.text;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  //hintText: 'ENTER',
                                  //labelText: 'Phone Number'
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 5, 66, 116),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: SizedBox(
                        width: width / 12,
                        child: Center(
                          child: const Text(
                            'Agent',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 12,
                      child: const Text(
                        'Date',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: width / 12,
                      child: const Text(
                        'Check In',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: width / 12,
                      child: const Text(
                        'Check Out',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: width / 9,
                      child: const Text(
                        'Location',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: width / 9,
                      child: const Text(
                        'Status',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height / 1.3,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream:
                      chat.doc(widget.ids).collection('attendance').snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ResponsiveGridList(
                          horizontalGridSpacing:
                              16, // Horizontal space between grid items

                          horizontalGridMargin:
                              50, // Horizontal space around the grid
                          verticalGridMargin:
                              10, // Vertical space around the grid
                          minItemWidth:
                              300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                          minItemsPerRow:
                              1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                          maxItemsPerRow:
                              1, // The maximum items to show in a single row. Can be useful on large screens
                          listViewBuilderOptions:
                              ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                          children: List.generate(
                              streamSnapshot.data!.docs
                                  .where((element) => element['date']
                                      .toString()
                                      .contains(search))
                                  .length, (index) {
                            final filteredData = streamSnapshot.data!.docs
                                .where((element) => element['date']
                                    .toString()
                                    .contains(search));
                            final documentSnapshot =
                                filteredData.elementAt(index);
                            if (documentSnapshot['date']
                                .toString()
                                .startsWith(search)) {
                              return InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 102, 100, 100)
                                                .withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 1)
                                      ]),

                                  //color: Colors.amber,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        //crossAxisAlignment: CrossAxisAlignment.,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              documentSnapshot['userid'],
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              documentSnapshot['date'],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              documentSnapshot['checkin_time'],
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              documentSnapshot['checkout_time'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                      .withOpacity(0.6)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 170,
                                            child: Text(
                                              documentSnapshot['location'],
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  documentSnapshot['status'],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black
                                                          .withOpacity(0.9)),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2),
                                                child: InkWell(
                                                  onTap: () {
                                                    dialog(context,
                                                        documentSnapshot.id);
                                                  },
                                                  child: Container(
                                                      height: 36,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              25, 120, 198),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2))),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ); // The list of widgets in the list
                            }
                            return const SizedBox(
                              height: 1,
                            );
                          }));
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            )
          ],
        ));
  }

  dialog(BuildContext context, id) {
    var width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 250,
                  width: 300,
                  child: Lottie.asset('assets/dddd.json',
                      fit: BoxFit.cover, repeat: true),
                ),
                const SizedBox(
                  height: 48,
                ),
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    onPressed: () {
                      updateattendanceagain(id);
                      Navigator.pop(context);
                      //dialog2(context, id);
                    },
                    color: const Color.fromARGB(255, 4, 53, 94),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      child: Text(
                        'Mark As Present',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    onPressed: () {
                      updateattendance(id);
                      Navigator.pop(context);
                    },
                    color: const Color.fromARGB(255, 4, 53, 94),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      child: Text(
                        'Mark As Absent',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  mobileView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 66, 116),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 102, 100, 100)
                                .withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Row(
                    children: [
                      Container(
                        height: 45,
                        width: 49,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 5, 66, 116),
                                Color.fromARGB(255, 0, 90, 163)
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Center(
                              child: Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 220,
                        height: 45,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: TextField(
                              controller: searchcontroller,
                              onChanged: (value) {
                                setState(() {
                                  search = searchcontroller.text;
                                });
                              },
                              onEditingComplete: () {
                                setState(() {
                                  search = searchcontroller.text;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                //hintText: 'ENTER',
                                //labelText: 'Phone Number'
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          SizedBox(
            height: height - 160,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                stream:
                    chat.doc(widget.ids).collection('attendance').snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ResponsiveGridList(
                        horizontalGridSpacing:
                            16, // Horizontal space between grid items

                        horizontalGridMargin:
                            10, // Horizontal space around the grid
                        verticalGridMargin:
                            10, // Vertical space around the grid
                        minItemWidth:
                            400, // The minimum item width (can be smaller, if the layout constraints are smaller)
                        minItemsPerRow:
                            1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                        maxItemsPerRow:
                            1, // The maximum items to show in a single row. Can be useful on large screens
                        listViewBuilderOptions:
                            ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                        children: List.generate(
                            streamSnapshot.data!.docs.length, (index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          if (documentSnapshot['date']
                              .toString()
                              .toLowerCase()
                              .startsWith(search)) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Colors.grey.withOpacity(0.5), //New
                                        blurRadius: 1,
                                        spreadRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(5)),
                              height: height / 4,
                              //color: Colors.amber,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(left: 0),
                                          child: Text(
                                            'User Id',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Check in',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Check Out',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Location',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      //crossAxisAlignment: CrossAxisAlignment.,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          documentSnapshot['userid'],
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          documentSnapshot['date'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        Text(
                                          documentSnapshot['checkin_time'],
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          documentSnapshot['checkout_time'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            documentSnapshot['location'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ); // The list of widgets in the list
                          }
                          return SizedBox(
                            height: 1,
                          );
                        }));
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )
        ],
      ),
    );
  }
}
