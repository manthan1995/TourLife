import 'package:flutter/material.dart';
import '../constant/colorses.dart';

class CommanHeaderBg extends StatelessWidget {
  CommanHeaderBg(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.date,
      required this.coverPic,
      required this.profilePic,
      required this.month})
      : super(key: key);
  String title;
  String subTitle;
  String date;
  String month;
  String profilePic;
  String coverPic;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: size.width,
          height: size.height * 0.22,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            color: Colorses.black,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            child: Image.network(
              coverPic,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 50, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(profilePic)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontFamily: 'Inter-Medium',
                            color: Colorses.white,
                            fontSize: 22),
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                            fontFamily: 'Inter-Light',
                            color: Colorses.white,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        color: Colorses.white,
                        fontSize: 30),
                  ),
                  Text(
                    month,
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        color: Colorses.white,
                        fontSize: 16),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
