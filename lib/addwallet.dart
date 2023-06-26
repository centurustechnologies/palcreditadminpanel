import 'payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class AddWallet extends StatefulWidget {
  final String ids;
  const AddWallet({
    super.key,
    required this.ids,
  });

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  TextEditingController aubank = TextEditingController();
  TextEditingController indusind = TextEditingController();

  //TextEditingController useridController = TextEditingController();
  TextEditingController baroda = TextEditingController();
  TextEditingController hdfc = TextEditingController();
  TextEditingController idfc = TextEditingController();
  TextEditingController icici = TextEditingController();

  TextEditingController sbi = TextEditingController();
  TextEditingController standard = TextEditingController();
  TextEditingController yes = TextEditingController();
  TextEditingController hdfconline = TextEditingController();

  Future wallet() async {
    await FirebaseFirestore.instance
        .collection('userwallet')
        .doc(widget.ids)
        .set({
      'balance': '0',
      'id': widget.ids,
      'sbi:': sbi.text,
      'aubank': aubank.text,
      'indusind': indusind.text,
      'baroda': baroda.text,
      'hdfc': hdfc.text,
      'idfc': idfc.text,
      'icici': icici.text
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //print(widget.ids);
    super.initState();
  }

  bool back = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: back
          ? Payments(ids: widget.ids)
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
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
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 1.25,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Banks')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                        if (streamSnapshot.hasData) {
                          return ResponsiveGridList(
                              horizontalGridSpacing: 16,
                              horizontalGridMargin: 20,
                              minItemWidth: 270,
                              minItemsPerRow: 1,
                              maxItemsPerRow: 1,
                              listViewBuilderOptions: ListViewBuilderOptions(
                                  scrollDirection: Axis.vertical),
                              children: List.generate(
                                  streamSnapshot.data!.docs.length, (index) {
                                if (streamSnapshot.hasData) {
                                  DocumentSnapshot documentSnapshot =
                                      streamSnapshot.data!.docs[index];
                                  return SizedBox(
                                    height: 70,
                                    width: width / 2.5,
                                    child: Row(children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          documentSnapshot['bank_name'],
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 60,
                                          width: width / 3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: const Color.fromARGB(
                                                            255, 102, 100, 100)
                                                        .withOpacity(0.4),
                                                    spreadRadius: 1,
                                                    blurRadius: 1)
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, bottom: 6),
                                            child: TextField(
                                              controller: index == 0
                                                  ? aubank
                                                  : index == 1
                                                      ? indusind
                                                      : index == 2
                                                          ? hdfconline
                                                          : index == 3
                                                              ? indusind
                                                              : index == 4
                                                                  ? standard
                                                                  : index == 5
                                                                      ? yes
                                                                      : index ==
                                                                              6
                                                                          ? hdfc
                                                                          : index == 7
                                                                              ? idfc
                                                                              : index == 8
                                                                                  ? icici
                                                                                  : sbi,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    5)
                                              ],
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Enter Amount',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  );
                                }
                                return CircularProgressIndicator();
                              }));
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  child: Container(
                    height: 48,
                    width: width / 4.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      gradient: const LinearGradient(colors: [
                        Colors.blue,
                        Color.fromARGB(255, 8, 71, 123)
                      ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (aubank.text.isNotEmpty) {
                          wallet();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Please fill all mandatory fields'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        }
                      },
                      //color: Colors.blue,
                      height: 38,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Add User',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
