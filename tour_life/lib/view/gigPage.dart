import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tour_life/constant/images.dart';
import 'package:tour_life/constant/lists.dart';
import '../constant/colorses.dart';
import '../constant/strings.dart';
import '../widget/commanAppBar.dart';
import '../widget/commanHeaderBg.dart';

class GigPage extends StatefulWidget {
  const GigPage({Key? key}) : super(key: key);

  @override
  _GigPageState createState() => _GigPageState();
}

class _GigPageState extends State<GigPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppbar(
        context: context,
        text: Strings.gigStr,
      ),
      body: Container(
        color: Colorses.red,
        child: Column(
          children: [
            Stack(
              children: [
                buildHeaderbg(),
                buildCard(size: size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderbg() {
    return CoomanHeaderBg();
  }

  Widget buildCard({Size? size}) {
    return Container(
      margin: EdgeInsets.only(
        left: size!.height * 0.02,
        right: size.height * 0.02,
        top: size.height * 0.16,
      ),
      padding: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: Colorses.white,
        boxShadow: [
          BoxShadow(
            color: Colorses.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            // shadow direction: bottom right
          )
        ],
      ),
      width: size.width,
      height: size.height * 0.60,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 8,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                buildListTile(
                  leadingImage: Lists.giglistImage[index],
                  text: Lists.giglist[index],
                ),
                Container(
                  height: 1,
                  color: Colorses.grey,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                )
              ],
            );
          })),
    );
  }

  Widget buildListTile({String? text, Widget? trailing, String? leadingImage}) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: ListTile(
        leading: SvgPicture.asset(leadingImage!),
        title: Center(
          child: Text(
            text!,
            style: TextStyle(
              color: Colorses.black,
              fontSize: 18,
              fontFamily: 'Inter-Bold',
            ),
          ),
        ),
        trailing: Container(
          alignment: Alignment.center,
          height: 25,
          width: 25,
          child: Text(
            "5",
            style: TextStyle(color: Colorses.white),
          ),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              color: Colorses.red,
              boxShadow: [
                BoxShadow(
                  color: Colorses.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  // shadow direction: bottom right
                ),
              ]),
        ),
      ),
    );
  }
}
