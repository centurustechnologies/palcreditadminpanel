import 'admincontrol.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Admins extends StatefulWidget {
  const Admins({super.key});

  @override
  State<Admins> createState() => _AdminsState();
}

class _AdminsState extends State<Admins> {
  TextEditingController changepasscontroller = TextEditingController();

  final CollectionReference chat =
      FirebaseFirestore.instance.collection('admins');

  bool newadmin = false;

  Future changepass(String id) async {
    FirebaseFirestore.instance
        .collection('admins')
        .doc(id)
        .update({'password': changepasscontroller.text});
  }

  bool password = false;

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    // ignore: deprecated_member_use
    return ScreenTypeLayout(
      mobile: mobileView(context),
      tablet: mobileView(context),
      desktop: desktopview(context),
    );
  }

  desktopview(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 4, 63, 111),
      ),
      body: newadmin
          ? const AdminControl()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      newadmin = true;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 41, bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 6),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 92, 154, 205),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Add new Admin',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
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
                            width: width / 11,
                            child: Center(
                              child: const Text(
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
                          width: width / 10,
                          child: const Text(
                            'Password',
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
                  height: height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder(
                      stream: chat.snapshots(),
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
                                  streamSnapshot.data!.docs.length, (index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    dialog(context, documentSnapshot.id);
                                    print(documentSnapshot.id);
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
                                                color: const Color.fromARGB(
                                                        255, 102, 100, 100)
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  documentSnapshot['name'],
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  documentSnapshot['Location'],
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.start,
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
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.6)),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 120,
                                                child: Text(
                                                  documentSnapshot[
                                                      'register_date'],
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.6),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              password
                                                  ? InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          password = false;
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
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          password = true;
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
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    )
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

  mobileView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 30, 52),
      ),
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
                MaterialPageRoute(builder: (context) => const AdminControl()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 92, 154, 205),
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  'Add new Admin',
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
                              dialog(context, documentSnapshot.id);
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
                                          'Location',
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
                                          'Email',
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
                                          documentSnapshot['Location'],
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
                                          documentSnapshot['register_date'],
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          documentSnapshot['email'],
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
                  return Center(child: CircularProgressIndicator());
                }),
          )
        ],
      ),
    );
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
                Container(
                  height: 250,
                  width: 300,
                  child: Lottie.asset('assets/sucess.json',
                      fit: BoxFit.cover, repeat: true),
                ),
                const SizedBox(
                  height: 48,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 102, 100, 100)
                                  .withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 2),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        controller: changepasscontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter new password here',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: 250,
                  child: Text(
                    'Click ok button to change password of this admin',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 94, 94, 94),
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  child: MaterialButton(
                    onPressed: () {
                      if (changepasscontroller.text.isNotEmpty) {
                        changepass(id);
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                      }

                      //dialog1(context);
                    },
                    color: const Color.fromARGB(255, 4, 53, 94),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 80),
                      child: Text(
                        'ok',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
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
}
