import 'package:flutter/material.dart';

class RickPic extends StatelessWidget {
  const RickPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/images/Rick.png"),
          )),
    );
  }
}
