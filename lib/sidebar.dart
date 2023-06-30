import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:universal_html/html.dart';

import 'agents.dart';
import 'bro.dart';
import 'home.dart';
import 'leads.dart';
import 'walle.dart';

class SidebarXExampleApp extends StatefulWidget {
  const SidebarXExampleApp({Key? key}) : super(key: key);

  @override
  State<SidebarXExampleApp> createState() => _SidebarXExampleAppState();
}

class _SidebarXExampleAppState extends State<SidebarXExampleApp> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  final _key = GlobalKey<ScaffoldState>();
  bool showDashboard = true;
  bool showEstrudias = false;
  bool showOrderHistory = false;
  bool showBannerPanel = false;
  bool showSettings = false;
  bool showFeedback = false;
  bool showReport = false;
  Future<bool> willPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPop,
      child: MaterialApp(
        title: 'Pal Credits',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 63, 111),
          canvasColor: const Color.fromARGB(255, 4, 63, 111),
          scaffoldBackgroundColor: white,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              color: Colors.white,
              fontSize: 46,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        home: Builder(
          builder: (context) {
            final isSmallScreen = MediaQuery.of(context).size.width < 600;
            return Scaffold(
              key: _key,
              appBar: isSmallScreen
                  ? AppBar(
                      backgroundColor: const Color.fromARGB(255, 4, 63, 111),
                      elevation: 2,
                    )
                  : null,
              drawer: ExampleSidebarX(controller: _controller),
              body: Row(
                children: [
                  if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                  Expanded(
                    child: Center(
                      child: _ScreensExample(
                        controller: _controller,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExampleSidebarX extends StatefulWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  State<ExampleSidebarX> createState() => _ExampleSidebarXState();
}

class _ExampleSidebarXState extends State<ExampleSidebarX> {
  String location = '';

  Future getadmindata(String id) async {
    await FirebaseFirestore.instance
        .collection('admins')
        .doc(id)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          location = value.get('Location');
          //pass = value.get('password');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return SidebarX(
      controller: widget._controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 4, 63, 111),
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: const Color.fromARGB(255, 15, 96, 162),
        textStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        // itemDecoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(color: Colors.black.withOpacity(0.7)),
        // ),
        selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            color: const Color(0xff17D29C)),
        iconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return extended
            ? SizedBox(
                width: 100,
                child: Image.asset(
                  'assets/logo7.png',
                  fit: BoxFit.cover,
                ),
              )
            : SizedBox(
                height: 150,
                child: Image.asset(
                  'assets/logo8.png',
                  fit: BoxFit.cover,
                ),
              );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            isSmallScreen ? Navigator.pop(context) : null;
          },
        ),
        SidebarXItem(
          icon: Icons.leaderboard,
          label: 'Leads',
          onTap: () {
            isSmallScreen ? Navigator.pop(context) : null;
          },
        ),
        SidebarXItem(
          icon: Icons.support_agent,
          label: 'Agents',
          onTap: () {
            isSmallScreen ? Navigator.pop(context) : null;
          },
        ),
        SidebarXItem(
          icon: Icons.money,
          label: 'Banks',
          onTap: () {
            isSmallScreen ? Navigator.pop(context) : null;
          },
        ),
        SidebarXItem(
          icon: Icons.credit_card,
          label: 'Wallet',
          onTap: () {
            isSmallScreen ? Navigator.pop(context) : null;
          },
        ),
      ],
    );
  }
}

class _ScreensExample extends StatefulWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  State<_ScreensExample> createState() => _ScreensExampleState();
}

class _ScreensExampleState extends State<_ScreensExample> {
  String localtoken = '';
  checkLogin() {
    String? token = window.localStorage['userid'];

    if (token != null) {
      setState(() {
        localtoken = token;
      });
    } else {
      setState(() {
        localtoken = '';
      });
    }
    print(localtoken);
    //log('user number is splash $token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        //final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (widget.controller.selectedIndex) {
          case 0:
            return Home(
              ids: localtoken,
            );
          case 1:
            return Leads(
              ids: localtoken,
            );

          case 2:
            return Agents(
              ids: localtoken,
            );
          case 3:
            return const Bro();

          default:
            return Wallet(
              ids: localtoken,
            );
        }
      },
    );
  }
}

const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
