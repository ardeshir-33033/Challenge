import 'package:behtarino/Controllers/SignUpController.dart';
import 'package:behtarino/Controllers/VerifySmsController.dart';
import 'package:behtarino/Utilities/Base.dart';
import 'package:behtarino/View/Widgets/AuthWidgets/SignUpButtonWidget.dart';
import 'package:behtarino/View/Widgets/AuthWidgets/SignUpTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    CBase().setDeviceDimension(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    return Scaffold(
      backgroundColor: Color(0xFFFCEDEA),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  SizedBox(
                    height: CBase().getFullHeight(context) / 7,
                  ),
                  Text(
                    "هپی چت",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: CBase().getFullHeight(context) / 15,
                  ),
                  Text(
                    "برای ثبت نام شماره خود را وارد کنید.",
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  SignUpTextField(controller: controller),
                  GetBuilder<SignUpController>(
                      id: "validate",
                      builder: (_) {
                        return Visibility(
                          visible: !controller.validate,
                          child: Text(
                            controller.errorMessage ?? "",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: CBase().getSmallfontSizeByScreen()),
                          ),
                        );
                      })
                ],
              ),
            ),
            SignUpButton(),
          ],
        ),
      ),
    );
  }
}
