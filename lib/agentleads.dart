import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AgentsLead extends StatefulWidget {
  final String password;
  //final String cardtype;

  const AgentsLead({
    super.key,
    required this.password,
  });

  @override
  State<AgentsLead> createState() => _AgentsLeadState();
}

class _AgentsLeadState extends State<AgentsLead> {
  List category = [
    'Applicant Mobile no.',
    'date of birth',
    'Mother name',
    'Email',
    'pan Number',
    'Pin Code',
    'Current Adress',
    'LandMark',
    'company name',
    'Designation',
    'Official adress',
    'Existing Card Bank',
    'Existing Card Limit',
    'Existing Card Vintage',
    'Net Monthly Income',
    'ITR Slip',
    'location'
  ];
  final CollectionReference Payments =
      FirebaseFirestore.instance.collection('leads');

  @override
  Widget build(BuildContext context) {
    bool customTileExpanded = true;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 7, 70, 121),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 5, 66, 116),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            SizedBox(
              height: height / 1.25,
              child: StreamBuilder(
                  stream: Payments.where('location', isEqualTo: '').snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                                streamSnapshot.data!.docs.length, (index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];

                              if (documentSnapshot['location'] == "") {
                                return ExpansionTile(
                                  trailing: const SizedBox(
                                    height: 1,
                                    width: 1,
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Container(
                                      width: width,
                                      //color: Colors.amber,
                                      //height: height / 21,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        //crossAxisAlignment: CrossAxisAlignment.,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              documentSnapshot['Bank_name'],
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 9,
                                                      vertical: 3),
                                              child: Text(
                                                documentSnapshot[
                                                    'application_status'],
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400,
                                                    color: documentSnapshot[
                                                                'application_status'] ==
                                                            'sucess'
                                                        ? const Color.fromARGB(
                                                            255, 83, 237, 89)
                                                        : Colors.orange),
                                                textAlign: TextAlign.start,
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
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              documentSnapshot['userid'] == ''
                                                  ? documentSnapshot['token']
                                                  : documentSnapshot['userid'],
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 120,
                                            child: Row(
                                              children: [
                                                Text(
                                                  documentSnapshot['card_type'],
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: InkWell(
                                              onTap: () {
                                                //add();
                                              },
                                              child: Container(
                                                  height: 36,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              25,
                                                              120,
                                                              198),
                                                      border: Border.all(
                                                          color: Colors.black
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
                                    ),
                                  ),
                                  //subtitle: Text('Trailing expansion arrow icon'),
                                  children: <Widget>[
                                    Container(
                                      height: height / 1.8,
                                      width: double.infinity,
                                      color: Colors.blue.withOpacity(0.1),
                                      child: ResponsiveGridList(
                                          horizontalGridSpacing:
                                              16, // Horizontal space between grid items
                                          //horizontalGridSpacing: 16, // Vertical space between grid items
                                          horizontalGridMargin:
                                              20, // Horizontal space around the grid
                                          verticalGridMargin: 10,
                                          minItemWidth:
                                              200, // The minimum item width (can be smaller, if the layout constraints are smaller)
                                          minItemsPerRow:
                                              1, // The minimum items to show in a single row. Takes precedence over minItemWidth
                                          maxItemsPerRow:
                                              5, // The maximum items to show in a single row. Can be useful on large screens
                                          listViewBuilderOptions:
                                              ListViewBuilderOptions(), // Options that are getting passed to the ListView.builder() function
                                          children: List.generate(17, (index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Text(
                                                    category[index],
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black
                                                            .withOpacity(0.8)),
                                                  ),
                                                ),
                                                Container(
                                                  height: 40,
                                                  width: width / 6,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.7), //New
                                                          blurRadius: 1.0,
                                                          spreadRadius: 0.5)
                                                    ],
                                                  ),
                                                  child: SizedBox(
                                                    width: width / 7,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 6, top: 6),
                                                      child: Text(
                                                        index == 0
                                                            ? documentSnapshot[
                                                                'mobile_number']
                                                            : index == 1
                                                                ? documentSnapshot[
                                                                    'Date_of_birth']
                                                                : index == 2
                                                                    ? documentSnapshot[
                                                                        'mother_name']
                                                                    : index == 3
                                                                        ? documentSnapshot[
                                                                            'email']
                                                                        : index ==
                                                                                4
                                                                            ? documentSnapshot['national_id']
                                                                            : index == 5
                                                                                ? documentSnapshot['pin_code']
                                                                                : index == 6
                                                                                    ? documentSnapshot['current_adress']
                                                                                    : index == 7
                                                                                        ? documentSnapshot['landmark']
                                                                                        : index == 8
                                                                                            ? documentSnapshot['companyname']
                                                                                            : index == 9
                                                                                                ? documentSnapshot['Designation']
                                                                                                : index == 10
                                                                                                    ? documentSnapshot['work_place']
                                                                                                    : index == 11
                                                                                                        ? documentSnapshot['existing_card_bank_name']
                                                                                                        : index == 12
                                                                                                            ? documentSnapshot['existing_card_limit']
                                                                                                            : index == 13
                                                                                                                ? documentSnapshot['existing_card_vintage']
                                                                                                                : index == 14
                                                                                                                    ? documentSnapshot['gross_monthly_icome']
                                                                                                                    : index == 14
                                                                                                                        ? documentSnapshot['yearly_return_details']
                                                                                                                        : documentSnapshot['location'],
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.7)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          })),
                                    )
                                  ],
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
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ));
  }
}
