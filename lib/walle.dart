import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'payment.dart';

class Wallet extends StatefulWidget {
  final String ids;
  const Wallet({
    super.key,
    required this.ids,
  });

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool addwallet = false;
  String id = 'ff';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: addwallet
          ? Payments(ids: id)
          : StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('agents').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ResponsiveGridList(
                      horizontalGridSpacing: 16,
                      horizontalGridMargin: 20,
                      verticalGridMargin: 15,
                      minItemWidth: 270,
                      minItemsPerRow: 4,
                      maxItemsPerRow: 5,
                      listViewBuilderOptions: ListViewBuilderOptions(
                          scrollDirection: Axis.vertical),
                      children: List.generate(streamSnapshot.data!.docs.length,
                          (index) {
                        DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              setState(() {
                                addwallet = true;
                                id = documentSnapshot.id;
                              });
                            });
                          },
                          child: Container(
                            height: 160,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.blue,
                                      spreadRadius: 1,
                                      blurRadius: 1)
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        documentSnapshot['name'],
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        documentSnapshot['designation']
                                            .toString()
                                            .toLowerCase(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      Text(
                                        documentSnapshot['mobile_number'],
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
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
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('userwallet')
                                                .where('id',
                                                    isEqualTo:
                                                        documentSnapshot.id)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    streamSnapshot) {
                                              if (streamSnapshot.hasData) {
                                                return ListView.builder(
                                                    itemCount: streamSnapshot
                                                        .data!.docs.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return const Icon(
                                                        Icons.done,
                                                        color: Colors.amber,
                                                        size: 33,
                                                      );
                                                    });
                                              }
                                              return const Icon(
                                                Icons.cancel,
                                                color: Color.fromARGB(
                                                    255, 4, 55, 97),
                                                size: 33,
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }));
                }
                return const Center(child: CircularProgressIndicator());
              }),
    );
  }
}
