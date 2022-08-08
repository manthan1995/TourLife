import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tour_life/constant/images.dart';
import 'package:tour_life/constant/strings.dart';
import 'package:tour_life/view/profile_screen/profile_screen.dart';

import '../../constant/colorses.dart';
import '../agenda/agenda_screen.dart';
import '../../provider/all_provider.dart';
import '../gigs/gig_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AllDataProvider allDataProvider = AllDataProvider();

  int newindex = 0;
  @override
  void initState() {
    allDataProvider = Provider.of<AllDataProvider>(context, listen: false);
    allDataProvider.allDataApiProvider.allDataApiProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colorses.red,
          body: const TabBarView(
            children: [
              AgendaPage(),
              GigListScreen(),
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
          boxShadow: const [
            // BoxShadow(
            //   color: Colorses.grey,
            //   blurRadius: 2.0,
            //   spreadRadius: 0.0,
            //   offset:
            //       const Offset(-2.0, -2.0), // shadow direction: bottom right
            // )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
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