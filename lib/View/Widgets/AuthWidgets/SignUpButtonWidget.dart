import 'package:behtarino/Controllers/SignUpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpButton extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: GetBuilder<SignUpController>(
        id: "Button",
        builder: (_) {
          return InkWell(
            onTap: () {
              controller.buttonPressed();
            },
            child: Container(
              height: 70,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color:
                    controller.activeButton ? Colors.black : Color(0xFFC4C4C4),
              ),
              child: GetBuilder<SignUpController>(
                  id: "Loading",
                  builder: (_) {
                    return Center(
                        child: controller.isLoading
                            ? CircularProgressIndicator(
                                color: Colors.grey,
                                backgroundColor: Colors.white,
                                strokeWidth: 2,
                              )
                            : Text(
                                "ثبت نام",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0),
                              ));
                  }),
            ),
          );
        },
      ),
    );
  }
}
