import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'controller.dart';
import 'sidebar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userid = TextEditingController();
  TextEditingController password = TextEditingController();

  String user = '';
  String pass = '';
  String id = '';

  Future getadmindata(String id) async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          user = value.get('userid');
          pass = value.get('password');
        });
        if (userid.text == user && password.text == pass) {
          LocalStorageHelper.saveValue('userid', user);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SidebarXExampleApp()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please fill correct all mandatory fields'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please fill correct all mandatory fields'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    });
  }

  // String localtoken = '';
  // checkLogin() {
  //   String? token = LocalStorageHelper.getValue('userid');

  //   if (token != null) {
  //     setState(() {
  //       localtoken = token;
  //     });
  //   } else {
  //     setState(() {
  //       localtoken = '';
  //     });
  //   }
  //   //log('user number is splash $token');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenTypeLayout(
      mobile: mobilelogin(context),
      tablet: mobilelogin(context),
      desktop: desktoplogin(
        context,
      ),
    ));
  }

  desktoplogin(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [
          0.1,
          0.3,
          0.6,
          0.9,
        ],
        colors: [
          Color.fromARGB(255, 15, 59, 94),
          Color.fromARGB(255, 18, 102, 171),
          Color.fromARGB(255, 146, 195, 235),
          Color.fromARGB(255, 82, 150, 206),
        ],
      )),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: height / 1.6,
              width: width / 1.3,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.8), //New
                      blurRadius: 3.0,
                      spreadRadius: 1)
                ],
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: height / 1.5,
                    width: width / 3.18,
                    color: Colors.white,
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: width < 1000
                              ? const EdgeInsets.only(left: 20)
                              : const EdgeInsets.only(left: 50),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Welcome to ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Pal Credits',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 0, top: 10),
                              //   child: SizedBox(
                              //     height: 80,
                              //     width: 100,
                              //     child: Image.asset(
                              //       'assets/logo7.png',
                              //       fit: BoxFit.contain,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: width < 1000
                              ? const EdgeInsets.only(left: 20)
                              : const EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Userid',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 300,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: TextField(
                                    controller: userid,
                                    decoration: InputDecoration(
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 15, 59, 94)),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 2, 39, 69)),
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(0.6),
                                            fontSize: 13),
                                        hintText: 'Enter id'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: width < 1000
                              ? const EdgeInsets.only(left: 20)
                              : const EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 300,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: TextField(
                                    controller: password,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 15, 59, 94)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 2, 39, 69)),
                                        ),
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                        hintText: '*******'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: width < 1000
                              ? const EdgeInsets.only(left: 20, top: 30)
                              : const EdgeInsets.only(left: 50, top: 30),
                          child: Row(
                            children: [
                              Text(
                                "can't login?",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                              width < 1100
                                  ? const SizedBox(
                                      width: 70,
                                    )
                                  : const SizedBox(
                                      width: 106,
                                    ),
                              MaterialButton(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                elevation: 5.0,
                                minWidth: 120,
                                height: 45,
                                color: const Color.fromARGB(255, 15, 59, 94),
                                child: const Text('Login',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.0,
                                        color: Colors.white)),
                                onPressed: () {
                                  if (userid.text.isNotEmpty &&
                                      password.text.isNotEmpty) {
                                    // setState(() {
                                    //   id = userid.text;
                                    // });
                                    getadmindata(userid.text);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: SizedBox(
                            width: 270,
                            child: Text(
                              'If you are not register than yoy are not admin,stay away from this pannel',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: height / 1.3,
                        width: width / 2.2,
                        // color: Colors.orange.withOpacity(0.7),
                        // decoration: const BoxDecoration(
                        //     gradient: LinearGradient(
                        //   begin: Alignment.topRight,
                        //   end: Alignment.bottomLeft,
                        //   stops: [
                        //     0.1,
                        //     0.3,
                        //     0.6,
                        //     0.9,
                        //   ],
                        //   colors: [
                        //     Color.fromARGB(255, 146, 195, 235),
                        //     Color.fromARGB(255, 82, 150, 206),
                        //     Color.fromARGB(255, 18, 102, 171),
                        //     Color.fromARGB(255, 15, 59, 94)
                        //   ],
                        // )),
                        child: Padding(
                          padding: width < 1300
                              ? const EdgeInsets.only(left: 40)
                              : const EdgeInsets.only(left: 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              // Text(
                              //   'Login to acess your admin pannel',
                              //   style: TextStyle(
                              //       color: Colors.white.withOpacity(0.7),
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w400),
                              // ),
                              // const SizedBox(
                              //   height: 50,
                              // ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: SizedBox(
                                  height: 410,
                                  width: 400,
                                  child: Image.asset(
                                    'assets/logo7.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: -70,
                        top: -70,
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 2, 39, 69),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                      Positioned(
                        left: -100,
                        bottom: -100,
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 13, 77, 130),
                              borderRadius: BorderRadius.circular(150)),
                        ),
                      ),
                      // Positioned(
                      //   right: width < 1300 ? 100 : 150,
                      //   bottom: width < 1300 ? 120 : 150,
                      //   child: Container(
                      //     height: 120,
                      //     width: 120,
                      //     decoration: BoxDecoration(
                      //         color: const Color.fromARGB(255, 2, 39, 69),
                      //         borderRadius: BorderRadius.circular(60)),
                      //   ),
                      // ),
                      Positioned(
                        left: -40,
                        top: -70,
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 13, 77, 130),
                              borderRadius: BorderRadius.circular(60)),
                        ),
                      ),
                      Positioned(
                        right: -100,
                        bottom: -100,
                        child: Container(
                          height: 210,
                          width: 210,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 2, 39, 69),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  mobilelogin(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [
          0.1,
          0.3,
          0.6,
          0.9,
        ],
        colors: [
          Color.fromARGB(255, 15, 59, 94),
          Color.fromARGB(255, 18, 102, 171),
          Color.fromARGB(255, 146, 195, 235),
          Color.fromARGB(255, 82, 150, 206),
        ],
      )),
      child: Center(
        child: Container(
          height: height / 1.3,
          width: width / 1.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: Image.asset(
                  'assets/logo7.png',
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Userid',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 300,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: TextField(
                          controller: userid,
                          decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 15, 59, 94)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 2, 39, 69)),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.6),
                                  fontSize: 13),
                              hintText: 'Enter id'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 300,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color.fromARGB(255, 15, 59, 94),
                              )),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 2, 39, 69)),
                              ),
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                              hintText: '*******'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 30),
                child: Row(
                  children: [
                    Text(
                      "can't login?",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      elevation: 5.0,
                      minWidth: 80,
                      height: 35,
                      color: const Color.fromARGB(255, 15, 59, 94),
                      child: const Text('Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                              color: Colors.white)),
                      onPressed: () {
                        if (userid.text.isNotEmpty &&
                            password.text.isNotEmpty) {
                          setState(() {
                            id = userid.text;
                          });
                          getadmindata(id);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
