import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:tour_life/view/profile.dart';

import '../constant/colorses.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int newindex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            ProfilePage(),
            ProfilePage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color: Colorses.black,
              boxShadow: [
                BoxShadow(
                  color: Colorses.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: const Offset(
                      -2.0, -2.0), // shadow direction: bottom right
                )
              ],
            ),
            child: ClipRRect(
              child: TabBar(
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 50),
                labelColor: Colors.red,
                unselectedLabelColor: Colors.white,
                indicator: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.red, width: 3.0),
                  ),
                ),
                onTap: (index) {
                  setState(() {
                    newindex = index;
                  });
                },
                tabs: [
                  Tab(
                      icon: Icon(
                        Icons.home,
                        color: newindex == 0 ? Colors.red : Colors.white,
                      ),
                      text: "Agenda"),
                  Tab(
                      icon: Icon(
                        Icons.camera_alt,
                        color: newindex == 1 ? Colors.red : Colors.white,
                      ),
                      text: "Gigs"),
                  Tab(
                      icon: Image.asset(
                        "assets/profile.png",
                        color: newindex == 2 ? Colors.red : Colors.white,
                      ),
                      text: "Profile"),
                ],
              ),
            )),
      ),
    );
  }
}
