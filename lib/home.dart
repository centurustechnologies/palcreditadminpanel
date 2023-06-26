import 'admins.dart';
import 'agentleads.dart';
import 'agents.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:lottie/lottie.dart';

import 'package:universal_html/html.dart';

class Home extends StatefulWidget {
  final String ids;
  const Home({
    super.key,
    required this.ids,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference Payments =
      FirebaseFirestore.instance.collection('leads');

  String location = '';
  String name = '';
  // ignore: non_constant_identifier_names
  String Adminname = '';
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
          Adminname = value.get('name');
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getadmindata();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 19),
              child: width < 600
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome  ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          Adminname,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome  ',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          Adminname,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
            ),
            Row(
              children: [
                location == 'ludhiana'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 19),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Admins()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 6),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 4, 63, 111),
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              'Admins',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 1,
                        width: 1,
                      ),
                Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: InkWell(
                    onTap: () {
                      window.localStorage.remove('userid');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 6),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 4, 63, 111),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width < 1000 ? height - 150 : 170,
          child: ResponsiveGridList(
              horizontalGridSpacing: 16,
              horizontalGridMargin: 20,
              minItemWidth: 270,
              minItemsPerRow: 1,
              maxItemsPerRow: 10,
              listViewBuilderOptions: ListViewBuilderOptions(
                  scrollDirection: MediaQuery.of(context).size.width < 1000
                      ? Axis.vertical
                      : Axis.horizontal),
              children: List.generate(
                4,
                (index) => InkWell(
                  onTap: () {
                    // location == 'ludhiana'
                    // ?
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => const AgentsLead(password: 'jhh')),
                    //   ):null;
                  },
                  child: Container(
                    height: width < 600 ? height / 4.5 : height / 5.5,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: index == 0
                            ? const Color.fromARGB(255, 237, 125, 117)
                            : index == 1
                                ? const Color.fromARGB(255, 97, 154, 201)
                                : index == 2
                                    ? const Color.fromARGB(255, 110, 226, 206)
                                    : const Color.fromARGB(255, 198, 101, 215)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                index == 0
                                    ? 'Total Leads'
                                    : index == 1
                                        ? 'Sucess Leads'
                                        : index == 2
                                            ? 'Under Process'
                                            : 'Pending Leads',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              StreamBuilder(
                                  stream: location == 'ludhiana'
                                      ? index == 0
                                          ? Payments.snapshots()
                                          : index == 1
                                              ? Payments.where('application_status',
                                                      isEqualTo: 'sucess')
                                                  .snapshots()
                                              : index == 2
                                                  ? Payments.where('location', isEqualTo: '')
                                                      .snapshots()
                                                  : Payments.where(
                                                          'application_status',
                                                          isEqualTo: 'Pending')
                                                      .snapshots()
                                      : index == 0
                                          ? Payments.where('location', isEqualTo: location)
                                              .snapshots()
                                          : index == 1
                                              ? Payments.where(
                                                      'application_status',
                                                      isEqualTo: 'sucess')
                                                  .where('location',
                                                      isEqualTo: location)
                                                  .snapshots()
                                              : Payments.where('location', isEqualTo: location)
                                                  .where('application_status',
                                                      isEqualTo: 'Pending')
                                                  .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                    if (streamSnapshot.hasData) {
                                      return Text(
                                        (streamSnapshot.data!.docs.length)
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                    return Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                              const SizedBox(
                                height: 32,
                              ),
                              Text(
                                'A.G.Financial Services',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
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
                                        ? Icons.currency_exchange
                                        : index == 2
                                            ? Icons.ring_volume
                                            : Icons.place,
                                color: Colors.white,
                                size: 33,
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
      ],
    ));
  }
}
