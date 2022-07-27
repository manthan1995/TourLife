import 'package:flutter/material.dart';

import '../../constant/colorses.dart';
import '../../constant/strings.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  _ForgetPassScreenState createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(child: buildMainView(size: size)),
    );
  }

  Widget buildMainView({Size? size}) {
    return Column(
      children: [
        Text(
          Strings.appNameStr,
          style: TextStyle(
            color: Colorses.white,
            fontSize: 40,
            fontFamily: 'Inter-Regular',
          ),
        )
      ],
    );
  }
}
