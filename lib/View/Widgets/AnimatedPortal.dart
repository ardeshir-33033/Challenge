import 'package:behtarino/Utilities/Base.dart';
import 'package:flutter/material.dart';

class AnimatedPortal extends StatefulWidget {
  const AnimatedPortal({Key? key}) : super(key: key);

  @override
  _AnimatedPortalState createState() => _AnimatedPortalState();
}

class _AnimatedPortalState extends State<AnimatedPortal> {
  bool selected = false;
  double height = 10.0;

  @override
  void initState() {
    // TODO: implement initState
    height = 10.0;
    resize();
    super.initState();
  }

  resize() {
    Future.delayed(Duration(milliseconds: 100), () {
      height = CBase().getFullHeight(context) / 5;
      setState(() {
        selected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: Image.asset("assets/images/portal.png"),
    );
  }
}
