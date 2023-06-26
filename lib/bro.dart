import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_network/image_network.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class Bro extends StatefulWidget {
  const Bro({super.key});

  @override
  State<Bro> createState() => _BroState();
}

class _BroState extends State<Bro> {
  final CollectionReference Payments =
      FirebaseFirestore.instance.collection('Banks');

  TextEditingController banknamecontroller = TextEditingController();
  TextEditingController cardnamecontroller = TextEditingController();
  UploadTask? uploadTask;
  Uint8List webImage = Uint8List(8);
  String selectfile = '';
  String selectfile1 = '';
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

  Future _pickImage1() async {
// ignore: unused_local_variable
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null) {
      setState(() {
        selectfile1 = fileResult.files.first.name;
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
        .doc(banknamecontroller.text)
        .set({
      'bank_name': banknamecontroller.text,
      'image': url.toString(),
    });
  }

  Future uploadcardFile() async {
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
        .doc(bankname)
        .collection('cards')
        .add({
      'card_name': cardnamecontroller.text,
      'image': url.toString(),
    });
  }

  bool cards = false;
  String bankname = '';

  bool mobilebankupload = false;
  bool creditcard = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile: mobileView(context),
      tablet: mobileView(context),
      desktop: desktopview(context),
    );
  }

  mobileView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return mobilebankupload
        ? Container(
            color: Colors.blue.withOpacity(0.1),
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 50,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            'Add Bank Name',
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
                        width: width / 1.2,
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
                          padding: const EdgeInsets.only(left: 15, bottom: 2),
                          child: TextField(
                            controller: banknamecontroller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter bank name',
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
                      child: const Text('Select pick here')),
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
                        if (banknamecontroller.text.isNotEmpty &&
                            selectfile != '') {
                          uploadFile();
                          setState(() {
                            mobilebankupload = false;
                          });
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
                              'Add Banks',
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
          )
        : cards
            ? Container(
                height: height,
                width: width,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '$bankname Cards',
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: InkWell(
                                onTap: () {
                                  dialog(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 6),
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromARGB(255, 4, 63, 111),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Text(
                                    'Add Cards',
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
                      ),
                    ),
                    SizedBox(
                      height: height - 160,
                      child: StreamBuilder(
                          stream: Payments.doc(bankname)
                              .collection('cards')
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
                                  listViewBuilderOptions:
                                      ListViewBuilderOptions(
                                          scrollDirection: Axis.vertical),
                                  children: List.generate(
                                      streamSnapshot.data!.docs.length,
                                      (index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];
                                    return SizedBox(
                                      height: 100,
                                      width: width / 1.2,
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
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  102,
                                                                  100,
                                                                  100)
                                                              .withOpacity(0.4),
                                                      spreadRadius: 1,
                                                      blurRadius: 1)
                                                ]),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Container(
                                                    height: 90,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14)),
                                                    child: ImageNetwork(
                                                      image: documentSnapshot[
                                                          'image'],
                                                      imageCache:
                                                          CachedNetworkImageProvider(
                                                        documentSnapshot[
                                                            'image'],
                                                      ),
                                                      height: 80,
                                                      width: 100,
                                                      fitWeb: BoxFitWeb.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                  child: Text(
                                                    documentSnapshot[
                                                        'card_name'],
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    );
                                  }));
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ),
                  ],
                ),
              )
            : Container(
                height: height,
                width: width,
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
                          children: [
                            const SizedBox(
                              width: 12,
                            ),
                            const Text(
                              'Listed Banks',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  mobilebankupload = true;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 92, 154, 205),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Text(
                                    'Add Bank',
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
                      ),
                    ),
                    SizedBox(
                      height: height - 150,
                      child: StreamBuilder(
                          stream: Payments.snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            if (streamSnapshot.hasData) {
                              return ResponsiveGridList(
                                  horizontalGridSpacing: 16,
                                  horizontalGridMargin: 20,
                                  minItemWidth: 270,
                                  minItemsPerRow: 1,
                                  maxItemsPerRow: 1,
                                  listViewBuilderOptions:
                                      ListViewBuilderOptions(
                                          scrollDirection: Axis.vertical),
                                  children: List.generate(
                                      streamSnapshot.data!.docs.length,
                                      (index) {
                                    final DocumentSnapshot documentSnapshot =
                                        streamSnapshot.data!.docs[index];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          cards = true;
                                          bankname =
                                              documentSnapshot['bank_name'];
                                        });
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: width / 1.3,
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
                                                        color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                102,
                                                                100,
                                                                100)
                                                            .withOpacity(0.4),
                                                        spreadRadius: 1,
                                                        blurRadius: 1)
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Container(
                                                      height: 70,
                                                      width: 90,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14)),
                                                      child: ImageNetwork(
                                                        image: documentSnapshot[
                                                            'image'],
                                                        imageCache:
                                                            CachedNetworkImageProvider(
                                                          documentSnapshot[
                                                              'image'],
                                                        ),
                                                        height: 70,
                                                        width: 80,
                                                        fitWeb: BoxFitWeb.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      documentSnapshot[
                                                          'bank_name'],
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    );
                                  }));
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ),
                  ],
                ),
              );
  }

  desktopview(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        const SizedBox(
                          width: 50,
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 140,
                          child: Text(
                            'Add Bank Name',
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
                          padding: const EdgeInsets.only(left: 15, bottom: 2),
                          child: TextField(
                            controller: banknamecontroller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter bank name',
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
                      child: const Text('Select pick here')),
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
                        if (banknamecontroller.text.isNotEmpty &&
                            selectfile != '') {
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
                              'Add Banks',
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
                      children: const [
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Listed Banks',
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
                      stream: Payments.snapshots(),
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
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      cards = true;
                                      bankname = documentSnapshot['bank_name'];
                                    });
                                  },
                                  child: SizedBox(
                                    height: 80,
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  height: 70,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  child: ImageNetwork(
                                                    image: documentSnapshot[
                                                        'image'],
                                                    imageCache:
                                                        CachedNetworkImageProvider(
                                                      documentSnapshot['image'],
                                                    ),
                                                    height: 70,
                                                    width: 80,
                                                    fitWeb: BoxFitWeb.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 150,
                                                child: Text(
                                                  documentSnapshot['bank_name'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              }));
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            ),
          ),
          cards
              ? Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '$bankname Cards',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: InkWell(
                                  onTap: () {
                                    dialog(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 6),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 4, 63, 111),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Text(
                                      'Add Cards',
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
                        ),
                      ),
                      SizedBox(
                        height: height - 100,
                        child: StreamBuilder(
                            stream: Payments.doc(bankname)
                                .collection('cards')
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
                                    listViewBuilderOptions:
                                        ListViewBuilderOptions(
                                            scrollDirection: Axis.vertical),
                                    children: List.generate(
                                        streamSnapshot.data!.docs.length,
                                        (index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      return SizedBox(
                                        height: 100,
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
                                                        color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                102,
                                                                100,
                                                                100)
                                                            .withOpacity(0.4),
                                                        spreadRadius: 1,
                                                        blurRadius: 1)
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Container(
                                                      height: 90,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14)),
                                                      child: ImageNetwork(
                                                        image: documentSnapshot[
                                                            'image'],
                                                        imageCache:
                                                            CachedNetworkImageProvider(
                                                          documentSnapshot[
                                                              'image'],
                                                        ),
                                                        height: 80,
                                                        width: 100,
                                                        fitWeb: BoxFitWeb.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    child: Text(
                                                      documentSnapshot[
                                                          'card_name'],
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      );
                                    }));
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            }),
                      ),
                    ],
                  ),
                )
              : Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Please Select a bank to see cards',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Lottie.asset('assets/sucess.json',
                            fit: BoxFit.cover, repeat: true),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  dialog(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Container(
              color: Colors.blue.withOpacity(0.1),
              width: width / 4.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 140,
                            child: Text(
                              'Add Card Name',
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
                          width: width < 600 ? width / 2 : width / 5,
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
                            padding: const EdgeInsets.only(left: 15, bottom: 2),
                            child: TextField(
                              controller: cardnamecontroller,
                              decoration: const InputDecoration(
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextButton(
                        onPressed: () {
                          _pickImage1();
                        },
                        child: const Text('Select pick here')),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
                    child: Container(
                      height: 48,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        gradient: const LinearGradient(
                            colors: [
                              Colors.blue,
                              Color.fromARGB(255, 8, 71, 123)
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (cardnamecontroller.text.isNotEmpty &&
                              selectfile1 != '') {
                            uploadcardFile();
                            Navigator.pop(context);
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
          );
        });
  }
}
