import 'addwallet.dart';
import 'walle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Payments extends StatefulWidget {
  final String ids;
  const Payments({
    super.key,
    required this.ids,
  });

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  String balance = '';
  String sbiprice = '';
  String hdfcprice = '';
  String idfcprice = '';
  String indusindprice = '';
  String auprice = '';
  Future getwalletdata() async {
    FirebaseFirestore.instance
        .collection('userwallet')
        .doc(widget.ids)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          balance = value.get('balance');
          sbiprice = value.get('sbi:');
          hdfcprice = value.get('hdfc');
          idfcprice = value.get('idfc');
          indusindprice = value.get('indusind');
          auprice = value.get('aubank');
        });
      }

      print(balance);
    });
  }

  bool existed = false;
  Future attendancecheck() async {
    //DateTime now = DateTime.now();
    final Query query = FirebaseFirestore.instance
        .collection('userwallet')
        .where('id', isEqualTo: widget.ids);

    query.get().then((querySnapshot) {
      if (querySnapshot.size == 1) {
        setState(() {
          existed = true;
        });
      } else {
        setState(() {
          existed = false;
        });
      }
    }).catchError((error) {});
  }

  final CollectionReference Payments =
      FirebaseFirestore.instance.collection('leads');

  final CollectionReference Payment =
      FirebaseFirestore.instance.collection('userwallet');
  String search = '';

  TextEditingController updatecontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();

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

  Future updatewallet(String str) async {
    await FirebaseFirestore.instance
        .collection('userwallet')
        .doc(widget.ids)
        .update({
      'balance': (double.parse(balance) + double.parse(str)).toString()
    });
  }

  Future updatewallet1(String str) async {
    await FirebaseFirestore.instance
        .collection('userwallet')
        .doc(widget.ids)
        .update({
      'balance': (double.parse(balance) - double.parse(str)).toString()
    });
    //updatestatus1();
  }

  Future updatestatus(String id) async {
    await FirebaseFirestore.instance
        .collection('leads')
        .doc(id)
        .update({'application_status': 'Sucess'});
  }

  Future deletestatus(String id) async {
    await FirebaseFirestore.instance.collection('leads').doc(id).delete();
  }

  Future updatestatus1(String id) async {
    FirebaseFirestore.instance
        .collection('userwallet')
        .doc(widget.ids)
        .collection('transactions')
        .doc(id)
        .update({'status': '1'});
  }

  @override
  void initState() {
    super.initState();
    getadmindata();
    getwalletdata();
    attendancecheck();
  }

  bool trans = false;
  bool addwallet = false;
  bool back = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      child: SizedBox(
        height: height,
        child: back
            ? const Wallet(ids: '')
            : addwallet
                ? AddWallet(ids: widget.ids)
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              back = true;
                            });
                          },
                          child: Container(
                            height: 35,
                            width: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                  colors: [
                                    Colors.blue,
                                    Color.fromARGB(255, 0, 90, 163)
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Center(
                                  child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 160,
                          child: ResponsiveGridList(
                              horizontalGridSpacing: 16,
                              horizontalGridMargin: 20,
                              minItemWidth: 270,
                              minItemsPerRow: 1,
                              maxItemsPerRow: 10,
                              listViewBuilderOptions: ListViewBuilderOptions(
                                  scrollDirection:
                                      MediaQuery.of(context).size.width < 1000
                                          ? Axis.vertical
                                          : Axis.horizontal),
                              children: List.generate(
                                2,
                                (index) => InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: width < 600
                                        ? height / 4.5
                                        : height / 5.5,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        color: index == 0
                                            ? const Color.fromARGB(
                                                255, 237, 125, 117)
                                            : const Color.fromARGB(
                                                255, 198, 101, 215)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: index == 0
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Wallet Balance',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      width: 110,
                                                      child: StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'userwallet')
                                                              .where('id',
                                                                  isEqualTo:
                                                                      widget
                                                                          .ids)
                                                              .snapshots(),
                                                          builder: (context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  streamSnapshot) {
                                                            if (streamSnapshot
                                                                .hasData) {
                                                              return ListView
                                                                  .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      itemCount: streamSnapshot
                                                                          .data!
                                                                          .docs
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        final DocumentSnapshot
                                                                            documentSnapshot =
                                                                            streamSnapshot.data!.docs[index];

                                                                        return Center(
                                                                          child:
                                                                              Text(
                                                                            documentSnapshot['balance'],
                                                                            style: const TextStyle(
                                                                                fontSize: 21,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w600),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                          ),
                                                                        );
                                                                      });
                                                            }
                                                            return const Text(
                                                              '0',
                                                              style: TextStyle(
                                                                  fontSize: 21,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            );
                                                          }),
                                                    ),
                                                    const SizedBox(
                                                      height: 32,
                                                    ),
                                                    Text(
                                                      'A.G.Financial Services',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 25,
                                                    ),
                                                    Icon(
                                                      index == 0
                                                          ? Icons.people
                                                          : index == 1
                                                              ? Icons
                                                                  .currency_exchange
                                                              : index == 2
                                                                  ? Icons
                                                                      .ring_volume
                                                                  : Icons.place,
                                                      color: Colors.white,
                                                      size: 33,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Sbi Bank',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      'Hdfc Bank',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      'Au Bank',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      'Idfc Bank',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      'Indusind Bank',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      sbiprice,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      hdfcprice,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      auprice,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      idfcprice,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      indusindprice,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        trans = false;
                                      });
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: const LinearGradient(
                                            colors: [
                                              Colors.blue,
                                              Color.fromARGB(255, 0, 90, 163)
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Center(
                                          child: Text(
                                            'Leads',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        trans = true;
                                      });
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: const LinearGradient(
                                            colors: [
                                              Colors.blue,
                                              Color.fromARGB(255, 0, 90, 163)
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Center(
                                          child: Text(
                                            'Transaction',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  existed
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            setState(() {
                                              addwallet = true;
                                            });
                                          },
                                          child: Container(
                                            height: 45,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.blue,
                                                    Color.fromARGB(
                                                        255, 0, 90, 163)
                                                  ],
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.topRight),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 0),
                                              child: Center(
                                                child: Text(
                                                  'Add Wallet',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              Container(
                                height: 30,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.blue,
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
                                    //ignore: prefer_const_constructors
                                    SizedBox(
                                      width: 220,
                                      height: 45,
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 4),
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
                                                    color: Colors.white,
                                                    width: 5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white)),
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        trans
                            ? const SizedBox(
                                height: 1,
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  color: const Color.fromARGB(255, 5, 66, 116),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: SizedBox(
                                          width: width / 12,
                                          child: const Center(
                                            child: Text(
                                              'Applied Bank',
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
                                          'Status',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width / 12,
                                        child: const Text(
                                          'Applicant',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width / 12,
                                        child: const Text(
                                          'Agent',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width / 9,
                                        child: const Text(
                                          'Applied Card',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Container(
                                        width: 40,
                                        //color: Colors.amber,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        trans
                            ? SizedBox(
                                height: height / 1.8,
                                width: 421,
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('userwallet')
                                        .doc(widget.ids)
                                        .collection('transactions')
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            streamSnapshot) {
                                      if (streamSnapshot.hasData) {
                                        return ResponsiveGridList(
                                            horizontalGridSpacing:
                                                6, // Horizontal space between grid items

                                            horizontalGridMargin:
                                                0, // Horizontal space around the grid
                                            verticalGridMargin:
                                                0, // Vertical space around the grid
                                            minItemWidth:
                                                300, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                            minItemsPerRow:
                                                1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                            maxItemsPerRow:
                                                1, // The maximum items to show in a single row. Can be useful on large screens

                                            listViewBuilderOptions:
                                                ListViewBuilderOptions(
                                                    shrinkWrap: true),
                                            children: List.generate(
                                                streamSnapshot
                                                    .data!.docs.length,
                                                //,
                                                (index) {
                                              final DocumentSnapshot
                                                  documentSnapshot =
                                                  streamSnapshot
                                                      .data!.docs[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 3),
                                                child: Container(
                                                  height: 65,
                                                  width: 70,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    102,
                                                                    100,
                                                                    100)
                                                                .withOpacity(
                                                                    0.6),
                                                            spreadRadius: 1,
                                                            blurRadius: 1)
                                                      ]),
                                                  child: Row(
                                                    children: [
                                                      documentSnapshot[
                                                                  'status'] ==
                                                              '1'
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10,
                                                                      right:
                                                                          20),
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        20,
                                                                        130,
                                                                        24)),
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .done_outline,
                                                                  size: 25,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                getwalletdata();
                                                                updatewallet1(
                                                                    documentSnapshot[
                                                                        'request']);
                                                                updatestatus1(
                                                                    documentSnapshot
                                                                        .id);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            20),
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          255,
                                                                          145,
                                                                          0)),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .request_quote,
                                                                    size: 25,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            documentSnapshot[
                                                                        'status'] ==
                                                                    '1'
                                                                ? "Completed"
                                                                : "Withdrawl Request",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            documentSnapshot[
                                                                'date'],
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.7),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        documentSnapshot[
                                                            'request'],
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const SizedBox(
                                                        width: 25,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }));
                                      }
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }),
                              )
                            : SizedBox(
                                height: height / 1.8,
                                child: StreamBuilder(
                                    stream: Payments.where('token',
                                            isEqualTo: widget.ids)
                                        .snapshots(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            streamSnapshot) {
                                      if (streamSnapshot.hasData) {
                                        return SizedBox(
                                          height: height / 1.2,
                                          child: ResponsiveGridList(
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
                                                          element['first_name']
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(
                                                                  search) ||
                                                          element['userid']
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(
                                                                  search) ||
                                                          element['token']
                                                              .toString()
                                                              .toLowerCase()
                                                              .contains(search))
                                                      .length, (index) {
                                                final filteredData =
                                                    streamSnapshot.data!.docs
                                                        .where((element) =>
                                                            element['first_name']
                                                                .toString()
                                                                .toLowerCase()
                                                                .contains(
                                                                    search) ||
                                                            element['userid']
                                                                .toString()
                                                                .toLowerCase()
                                                                .contains(
                                                                    search) ||
                                                            element['token']
                                                                .toString()
                                                                .toLowerCase()
                                                                .contains(
                                                                    search));
                                                final documentSnapshot =
                                                    filteredData
                                                        .elementAt(index);

                                                if (documentSnapshot[
                                                            'first_name']
                                                        .toString()
                                                        .toLowerCase()
                                                        .startsWith(search) ||
                                                    documentSnapshot['userid']
                                                        .toString()
                                                        .toLowerCase()
                                                        .startsWith(search) ||
                                                    documentSnapshot['token']
                                                        .toString()
                                                        .toLowerCase()
                                                        .startsWith(search)) {
                                                  return ExpansionTile(
                                                    trailing: const SizedBox(
                                                      height: 1,
                                                      width: 1,
                                                    ),
                                                    title: InkWell(
                                                      onTap: () {
                                                        // deletestatus(documentSnapshot.id);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 35),
                                                        child: SizedBox(
                                                          width: width,
                                                          //color: Colors.amber,
                                                          //height: height / 21,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            //crossAxisAlignment: CrossAxisAlignment.,
                                                            children: [
                                                              SizedBox(
                                                                width: 100,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                      'Bank_name'],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 150,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          9,
                                                                      vertical:
                                                                          3),
                                                                  child: Text(
                                                                    documentSnapshot[
                                                                        'application_status'],
                                                                    style: TextStyle(
                                                                        fontSize: 11,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: documentSnapshot['application_status'] == 'sucess'
                                                                            ? const Color.fromARGB(255, 83, 237, 89)
                                                                            : documentSnapshot['application_status'] == 'Sucess'
                                                                                ? const Color.fromARGB(255, 83, 237, 89)
                                                                                : Colors.orange),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      documentSnapshot[
                                                                          'first_name'],
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              Colors.black),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text(
                                                                  documentSnapshot[
                                                                              'userid'] ==
                                                                          ''
                                                                      ? documentSnapshot[
                                                                          'token']
                                                                      : documentSnapshot[
                                                                          'userid'],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 120,
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      documentSnapshot[
                                                                          'card_type'],
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color:
                                                                              Colors.black),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              documentSnapshot[
                                                                          'application_status'] ==
                                                                      'Sucess'
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              2),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {},
                                                                        child: Container(
                                                                            height: 36,
                                                                            width: 100,
                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.green, border: Border.all(color: Colors.black.withOpacity(0.2))),
                                                                            child: const Center(
                                                                              child: Text(
                                                                                'Delivered',
                                                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                textAlign: TextAlign.end,
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          vertical:
                                                                              2),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          getwalletdata();
                                                                          if (documentSnapshot['Bank_name'] ==
                                                                              'sbi bank') {
                                                                            updatewallet(
                                                                              sbiprice,
                                                                            );
                                                                            updatestatus(documentSnapshot.id);
                                                                          } else if (documentSnapshot['Bank_name'] ==
                                                                              'Au Small finance bank') {
                                                                            updatewallet(auprice);
                                                                            updatestatus(documentSnapshot.id);
                                                                          } else if (documentSnapshot['Bank_name'] ==
                                                                              'INDUSIND BANK') {
                                                                            updatewallet(indusindprice);
                                                                            updatestatus(documentSnapshot.id);
                                                                          } else if (documentSnapshot['Bank_name'] ==
                                                                              'idfc bank') {
                                                                            updatewallet(idfcprice);
                                                                            updatestatus(documentSnapshot.id);
                                                                          } else {
                                                                            updatewallet(
                                                                              hdfcprice,
                                                                            );
                                                                            updatestatus(documentSnapshot.id);
                                                                          }
                                                                        },
                                                                        child: Container(
                                                                            height: 36,
                                                                            width: 100,
                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color.fromARGB(255, 25, 120, 198), border: Border.all(color: Colors.black.withOpacity(0.2))),
                                                                            child: const Center(
                                                                              child: Text(
                                                                                'Send Money',
                                                                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                                                                                textAlign: TextAlign.end,
                                                                              ),
                                                                            )),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    //subtitle: Text('Trailing expansion arrow icon'),
                                                  );
                                                }
                                                return const SizedBox(
                                                  height: 0.5,
                                                  width: 0.5,
                                                );
                                              }) // The list of widgets in the list
                                              ),
                                        );
                                      }
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }),
                              ),
                      ],
                    ),
                  ),
      ),
    );
  }

  dialog1(BuildContext context, id) {
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
                SizedBox(
                  height: 250,
                  width: 300,
                  child: Lottie.asset('assets/sucess.json',
                      fit: BoxFit.cover, repeat: true),
                ),
                const SizedBox(
                  height: 48,
                ),
                const SizedBox(
                  width: 250,
                  child: Text(
                    'Click ok button to credit Money',
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
                      if (updatecontroller.text.isNotEmpty) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        //dialog1(context);
                      }
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
