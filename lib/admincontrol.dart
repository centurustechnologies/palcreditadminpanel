import 'admins.dart';
import 'sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:responsive_grid_list/responsive_grid_list.dart';

class AdminControl extends StatefulWidget {
  const AdminControl({super.key});

  @override
  State<AdminControl> createState() => _AdminControlState();
}

class _AdminControlState extends State<AdminControl> {
  TextEditingController firstnameController = TextEditingController();

  TextEditingController useridController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController designationController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Future<void> newAdmin() async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(useridController.text)
        .set({
      'userid': useridController.text,
      'password': passwordController.text,
      'name': firstnameController.text,
      'email': emailController.text,
      'mobile_number': mobilenumberController.text,
      'Location': designationController.text,
      'register_date': dateController.text,
    }).whenComplete(() {});
  }

  bool admin = false;

  Future check() async {
    final Query query = FirebaseFirestore.instance
        .collection('admins')
        .where('userid', isEqualTo: useridController.text);

    query.get().then((querySnapshot) {
      if (querySnapshot.size > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('This userid is already exist'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      } else {
        newAdmin();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SidebarXExampleApp()),
        );
      }
    }).catchError((error) {
      // Handle any errors
    });
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2050, 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ScreenTypeLayout(
      mobile: mobileView(context),
      tablet: mobileView(context),
      desktop: desktopView(context),
    );
  }

  desktopView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        const SizedBox(
          width: 70,
        ),
        SizedBox(
          height: height,
          width: width / 1.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 43,
                  width: 700,
                  color: Colors.blue.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Add New Admins',
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
                height: height / 1.5,
                child: ResponsiveGridList(
                    horizontalGridSpacing: 16,
                    horizontalGridMargin: 20,
                    minItemWidth: 270,
                    minItemsPerRow: 1,
                    maxItemsPerRow: 1,
                    listViewBuilderOptions:
                        ListViewBuilderOptions(scrollDirection: Axis.vertical),
                    children: List.generate(
                      7,
                      (index) => SizedBox(
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
                              index == 0
                                  ? 'Username'
                                  : index == 1
                                      ? 'Name'
                                      : index == 2
                                          ? 'Email'
                                          : index == 3
                                              ? 'Mobile Number'
                                              : index == 4
                                                  ? 'Register date'
                                                  : index == 5
                                                      ? 'Location'
                                                      : 'Password',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
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
                                  borderRadius: BorderRadius.circular(5),
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
                                padding: EdgeInsets.only(left: 15, bottom: 6),
                                child: TextField(
                                  onTap: index == 4
                                      ? () {
                                          _selectDate(context);
                                        }
                                      : () {},
                                  controller: index == 0
                                      ? useridController
                                      : index == 1
                                          ? firstnameController
                                          : index == 2
                                              ? emailController
                                              : index == 3
                                                  ? mobilenumberController
                                                  : index == 4
                                                      ? dateController
                                                      : index == 5
                                                          ? designationController
                                                          : passwordController,
                                  inputFormatters: index == 3
                                      ? <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(10)
                                        ]
                                      : <TextInputFormatter>[],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter here',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Container(
                  height: 48,
                  width: width / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    gradient: const LinearGradient(
                        colors: [Colors.blue, Color.fromARGB(255, 8, 71, 123)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (firstnameController.text.isNotEmpty &&
                          mobilenumberController.text.isNotEmpty &&
                          useridController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          designationController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        check();
                        //useridAdmin();
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
                      //newAgent();
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
        ),
      ],
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
                    width: 300, //,
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
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 2),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        //controller: changepasscontroller,
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
                      // changepass(id);
                      Navigator.pop(context);
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

  mobileView(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 50, 88),
        leading: const BackButton(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 43,
              width: width,
              color: Colors.blue.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Add New Admin',
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
            height: height / 1.6,
            child: ResponsiveGridList(
                horizontalGridSpacing: 16,
                horizontalGridMargin: 20,
                minItemWidth: 270,
                minItemsPerRow: 1,
                maxItemsPerRow: 1,
                listViewBuilderOptions:
                    ListViewBuilderOptions(scrollDirection: Axis.vertical),
                children: List.generate(
                  7,
                  (index) => SizedBox(
                    height: 85,
                    width: width / 2.5,
                    child: Column(children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 140,
                            child: Text(
                              index == 0
                                  ? 'Username'
                                  : index == 1
                                      ? 'Name'
                                      : index == 2
                                          ? 'Email'
                                          : index == 3
                                              ? 'Mobile Number'
                                              : index == 4
                                                  ? 'Register date'
                                                  : index == 5
                                                      ? 'Location'
                                                      : 'Password',
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
                          height: 40,
                          width: width - 100,
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
                            padding: EdgeInsets.only(left: 15, bottom: 11),
                            child: TextField(
                              inputFormatters: index == 3
                                  ? <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(10)
                                    ]
                                  : <TextInputFormatter>[],
                              onTap: index == 4
                                  ? () {
                                      _selectDate(context);
                                    }
                                  : () {},
                              controller: index == 0
                                  ? useridController
                                  : index == 1
                                      ? firstnameController
                                      : index == 2
                                          ? emailController
                                          : index == 3
                                              ? mobilenumberController
                                              : index == 4
                                                  ? dateController
                                                  : index == 5
                                                      ? designationController
                                                      : passwordController,
                              keyboardType: index == 3
                                  ? TextInputType.number
                                  : TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter username',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                )),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 25),
            child: Container(
              height: 48,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    colors: [Colors.blue, Color.fromARGB(255, 8, 71, 123)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight),
              ),
              child: MaterialButton(
                onPressed: () {
                  if (firstnameController.text.isNotEmpty &&
                      mobilenumberController.text.isNotEmpty &&
                      useridController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      designationController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    check();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please fill all mandatory fields'),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
