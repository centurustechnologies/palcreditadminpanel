import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'addagent.dart';
import 'agentwiseleads.dart';
import 'attendancerecord.dart';

class Agents extends StatefulWidget {
  final String ids;
  const Agents({
    super.key,
    required this.ids,
  });

  @override
  State<Agents> createState() => _AgentsState();
}

class _AgentsState extends State<Agents> {
  final CollectionReference chat =
      FirebaseFirestore.instance.collection('agents');

  String location = '';
  String name = '';
  Future getadmindata() async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(widget.ids)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          location = value.get('Location');
          name = value.get('userid');
        });
      }
    });
  }

  Future agentid(String id) async {
    await FirebaseFirestore.instance
        .collection('agents')
        .doc(id)
        .update({'mobile_id': ''});
  }

  Future deleteagent(String id) async {
    await FirebaseFirestore.instance.collection('agents').doc(id).delete();
  }

  bool newuser = false;

  String token = '';
  bool agents = false;
  bool password = false;
  bool agentlead = false;
  String token1 = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getadmindata();
  }

  TextEditingController searchcontroller = TextEditingController();
  String search = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile: mobileView(context),
      tablet: mobileView(context),
      desktop: desktopView(context),
    );
  }

  desktopView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
        child: newuser
            ? const AddUser()
            : agentlead
                ? LeadAgent(ids: token1)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                newuser = true;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 41, bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 11, vertical: 6),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 92, 154, 205),
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Text(
                                  'Add new agent',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: SizedBox(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 300,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color.fromARGB(
                                                          255, 102, 100, 100)
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
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10)),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.blue,
                                                      Color.fromARGB(
                                                          255, 0, 90, 163)
                                                    ],
                                                    begin: Alignment.bottomLeft,
                                                    end: Alignment.topRight),
                                              ),
                                              child: const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 0),
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 4),
                                                  child: TextField(
                                                    controller:
                                                        searchcontroller,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        search =
                                                            searchcontroller
                                                                .text;
                                                      });
                                                    },
                                                    onEditingComplete: () {
                                                      setState(() {
                                                        search =
                                                            searchcontroller
                                                                .text;
                                                      });
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 5.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white)),
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
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
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 41, bottom: 12, right: 41),
                                child: StreamBuilder(
                                    stream: location == 'ludhiana'
                                        ? chat.snapshots()
                                        : chat
                                            .where('location',
                                                isEqualTo: location)
                                            .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            streamSnapshot) {
                                      if (streamSnapshot.hasData) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 11, vertical: 6),
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 92, 154, 205),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Text(
                                            'Total agents  :  ${streamSnapshot.data!.docs.length}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        );
                                      }
                                      return const CircularProgressIndicator();
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          color: const Color.fromARGB(255, 5, 66, 116),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: SizedBox(
                                  width: width / 12,
                                  child: const Center(
                                    child: Text(
                                      'User Id',
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
                                  'User Name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: width / 12,
                                child: const Text(
                                  'Address',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: width / 12,
                                child: const Text(
                                  'Mobile Number',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: width / 12,
                                child: const Text(
                                  'Registration Date',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: width / 12,
                                child: const Text(
                                  'Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
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
                            stream: location == 'ludhiana'
                                ? chat.snapshots()
                                : chat
                                    .where('location', isEqualTo: location)
                                    .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasData) {
                                return ResponsiveGridList(
                                    horizontalGridSpacing:
                                        16, // Horizontal space between grid items

                                    horizontalGridMargin:
                                        50, // Horizontal space around the grid
                                    verticalGridMargin:
                                        20, // Vertical space around the grid
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
                                            .where((element) =>
                                                element['name']
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(search) ||
                                                element['userid']
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(search))
                                            .length, (index) {
                                      final filteredData = streamSnapshot
                                          .data!.docs
                                          .where((element) =>
                                              element['name']
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(search) ||
                                              element['userid']
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(search));
                                      final documentSnapshot =
                                          filteredData.elementAt(index);

                                      if (documentSnapshot['name']
                                              .toString()
                                              .toLowerCase()
                                              .startsWith(search) ||
                                          documentSnapshot['userid']
                                              .toString()
                                              .toLowerCase()
                                              .startsWith(search)) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              token1 =
                                                  documentSnapshot['userid'];
                                            });
                                            setState(() {
                                              agentlead = true;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                102,
                                                                100,
                                                                100)
                                                            .withOpacity(0.2),
                                                        spreadRadius: 1,
                                                        blurRadius: 1)
                                                  ]),

                                              //color: Colors.amber,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    //crossAxisAlignment: CrossAxisAlignment.,
                                                    children: [
                                                      SizedBox(
                                                        width: 100,
                                                        child: Text(
                                                          documentSnapshot[
                                                              'userid'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          documentSnapshot[
                                                              'name'],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .black),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          documentSnapshot[
                                                              'Area'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          documentSnapshot[
                                                              'mobile_number'],
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 120,
                                                        child: Text(
                                                          documentSnapshot[
                                                              'register_date'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      password ||
                                                              documentSnapshot
                                                                      .id ==
                                                                  documentSnapshot
                                                                      .id
                                                          ? InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  password =
                                                                      false;
                                                                });
                                                              },
                                                              child: SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'password'],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.6),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  password =
                                                                      true;
                                                                });
                                                              },
                                                              child: SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  '*******',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.9),
                                                                      fontSize:
                                                                          19,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 2),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              token =
                                                                  documentSnapshot[
                                                                      'password'];
                                                              //agentlead = true;
                                                            });
                                                            dialog(
                                                                context,
                                                                documentSnapshot[
                                                                    'password']);
                                                          },
                                                          child: Container(
                                                              height: 36,
                                                              width: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      25,
                                                                      120,
                                                                      198),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2))),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ); // The list of widgets in the list
                                      }
                                      return SizedBox();
                                    }));
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
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
                      child: const Icon(
                        Icons.close,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                Container(
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
                      agentid(id);

                      Navigator.pop(context);
                    },
                    color: const Color.fromARGB(255, 4, 53, 94),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      child: Text(
                        'Change Device Id',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Attendance(
                                  ids: id,
                                )),
                      );
                    },
                    color: const Color.fromARGB(255, 4, 53, 94),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      child: Text(
                        'check Attendace',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
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
                                        child: const Icon(
                                          Icons.close,
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 250,
                                    width: 300,
                                    child: Lottie.asset('assets/dddd.json',
                                        fit: BoxFit.cover, repeat: true),
                                  ),
                                  const SizedBox(
                                    height: 48,
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'are you sure youn want to delete this agent',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 48,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: MaterialButton(
                                          onPressed: () {
                                            // deleteagent(id);
                                            Navigator.pop(context);
                                          },
                                          color: Colors.amber,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 10),
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 140,
                                        child: MaterialButton(
                                          onPressed: () {
                                            deleteagent(id);
                                            Navigator.pop(context);
                                          },
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 7, horizontal: 10),
                                            child: Text(
                                              'Yes',
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
                                ],
                              ),
                            );
                          });
                    },
                    color: const Color.fromARGB(255, 109, 9, 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      child: Text(
                        'Delete Agent',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddUser()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 92, 154, 205),
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  'Add new agent',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height - 160,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                stream: chat.snapshots(),
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
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Attendance(
                                          ids: documentSnapshot['password'],
                                        )),
                              );
                            },
                            child: Container(
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
                                          'User Name',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Address',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Mobile Number',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Registration Date',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Password',
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
                                          documentSnapshot['name'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        Text(
                                          documentSnapshot['Area'],
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          documentSnapshot['mobile_number'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                        Text(
                                          '11-08-2022',
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          documentSnapshot['password'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ); // The list of widgets in the list
                        }));
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          )
        ],
      ),
    );
  }
}
