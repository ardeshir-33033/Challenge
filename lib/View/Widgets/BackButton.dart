import 'package:flutter/material.dart';

class backButton extends StatelessWidget {
  const backButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                color: Colors.grey, shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back,
              size: 20,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "بازگشت",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
