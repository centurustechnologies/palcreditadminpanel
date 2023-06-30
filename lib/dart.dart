import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dart extends StatefulWidget {
  const Dart({super.key});

  @override
  State<Dart> createState() => _DartState();
}

class _DartState extends State<Dart> {
  TextEditingController banknamecontroller = TextEditingController();
  UploadTask? uploadTask;
  Uint8List webImage = Uint8List(8);
  String selectfile = '';
  String selectfile1 = '';

  Future _pickImage() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    if (fileResult != null) {
      setState(() {
        selectfile = fileResult.files.first.name;
        webImage = fileResult.files.first.bytes!;
      });

      //print(selectfile);
    }
  }

  Future<void> uploadFile() async {
    Reference ref =
        FirebaseStorage.instance.ref().child('company/${DateTime.now()}.png');
    UploadTask uploadTask = ref.putData(
      webImage,
      SettableMetadata(contentType: 'image/png'),
    );

    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => print('Upload completed'));

    if (taskSnapshot.state == TaskState.success) {
      String url = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('lists').add({
        'au_bank_company': banknamecontroller.text,
        'link': url.toString(),
      });

      print('Upload and database insertion completed');
    } else {
      print('Upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
                child: Image.network(
                    'https://st4.depositphotos.com/6557968/22851/v/1600/depositphotos_228519744-stock-illustration-laptop-upload-file-peoples-document.jpg')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: const Text('Select pick here')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
              child: Container(
                height: 48,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  gradient: const LinearGradient(
                      colors: [Colors.blue, Color.fromARGB(255, 8, 71, 123)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (banknamecontroller.text.isNotEmpty &&
                        selectfile != '') {
                      uploadFile();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text('Please fill all mandatory fields'),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
    );
  }
}
