import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:universal_html/html.dart';

class Cards extends StatefulWidget {
  final String bankname;
  const Cards({
    super.key,
    required this.bankname,
  });

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final CollectionReference Payments =
      FirebaseFirestore.instance.collection('Banks');

  TextEditingController cardnamecontroller = TextEditingController();
  UploadTask? uploadTask;
  Uint8List webImage = Uint8List(8);
  String selectfile = '';

  Future _pickImage() async {
// ignore: unused_local_variable
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null) {
      setState(() {
        selectfile = fileResult.files.first.name;
        webImage = fileResult.files.first.bytes!;
      });

      //print(selectfile);
    }
  }

  Future uploadFile() async {
    Reference ref =
        FirebaseStorage.instance.ref().child('Banks/${DateTime.now()}.png');
    UploadTask uploadTask = ref.putData(
      webImage,
      SettableMetadata(contentType: 'image/png'),
    );
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(
          () => log('done'),
        )
        .catchError(
          (error) => log('something went wrong $error'),
        );
    String url = await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection('Banks')
        .doc(widget.bankname).collection('cards')
        .add({
      'card_name': cardnamecontroller.text,
      'image': url.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: Colors.blue.withOpacity(0.1),
            width: width / 4.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            'Add Card Type',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        width: width / 5.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 102, 100, 100)
                                          .withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 1)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 2),
                          child: TextField(
                            controller: cardnamecontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter card name',
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue)),
                  child: selectfile.isEmpty
                      ? Image.network(
                          'https://st4.depositphotos.com/6557968/22851/v/1600/depositphotos_228519744-stock-illustration-laptop-upload-file-peoples-document.jpg')
                      : Image.memory(
                          webImage,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextButton(
                      onPressed: () {
                        _pickImage();
                      },
                      child: Text('Select pick here')),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                  child: Container(
                    height: 48,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      gradient: const LinearGradient(colors: [
                        Colors.blue,
                        Color.fromARGB(255, 8, 71, 123)
                      ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (cardnamecontroller.text.isNotEmpty) {
                          uploadFile();
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
                              'Add cards',
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
          ),
          SizedBox(
            width: 100,
          ),
          Container(
            height: height,
            width: width / 3.6,
            color: Colors.blue.withOpacity(0.1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 43,
                    width: 350,
                    color: Colors.blue.withOpacity(0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${widget.bankname} Cards',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height - 100,
                  child: StreamBuilder(
                      stream: Payments.doc(widget.bankname).collection('cards').snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              if (streamSnapshot.hasData) {
                                return SizedBox(
                                  height: 70,
                                  width: width / 4.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                        height: 80,
                                        width: width / 5,
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 60,
                                              color: Colors.amber,

                                            ),
                                            Text(
                                              documentSnapshot['card_name'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              }
                              return CircularProgressIndicator();
                            }));
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
