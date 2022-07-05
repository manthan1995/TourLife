import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/images.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/view/profilePage.dart';

import '../constant/colorses.dart';
import 'agendaPage.dart';

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
          body: const TabBarView(
            children: [
              AgendaPage(),
              ProfilePage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: buildBottomNavigationBar()),
    );
  }

  Widget buildBottomNavigationBar() {
    return Container(
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
              offset:
                  const Offset(-2.0, -2.0), // shadow direction: bottom right
            )
          ],
        ),
        child: ClipRRect(
          child: TabBar(
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 50),
            labelColor: Colorses.red,
            unselectedLabelColor: Colorses.white,
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colorses.red, width: 3.0),
              ),
            ),
            onTap: (index) {
              setState(() {
                newindex = index;
              });
            },
            tabs: [
              Tab(
                  icon: SvgPicture.asset(
                    Images.agendaImage,
                    color: newindex == 0 ? Colorses.red : Colorses.white,
                    height: 25,
                  ),
                  text: Strings.agendaStr),
              Tab(
                  icon: SvgPicture.asset(
                    newindex == 1 ? Images.gigs2Image : Images.gigsImage,
                    height: 25,
                  ),
                  text: Strings.gigsStr),
              Tab(
                  icon: SvgPicture.asset(
                    Images.profileImage,
                    color: newindex == 2 ? Colorses.red : Colorses.white,
                    height: 25,
                  ),
                  text: Strings.profileStr),
            ],
          ),
        ));
  }
}
