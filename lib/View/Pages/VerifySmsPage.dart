import 'package:behtarino/Controllers/VerifySmsController.dart';
import 'package:behtarino/Utilities/Base.dart';
import 'package:behtarino/View/Widgets/BackButton.dart';
import 'package:behtarino/View/Widgets/VerifyTextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifySmsPage extends GetView<VerifySmsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCEDEA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: CBase().getFullHeight(context) / 14,
            ),
            backButton(),
            SizedBox(
              height: CBase().getFullHeight(context) / 25,
            ),
            Column(
              children: [
                Text(
                  "هپی چت",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: CBase().getFullHeight(context) / 15,
                ),
                Text(
                  "برای ثبت‌نام کد ۴ رقمی ارسال شده را وارد نمایید.",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<VerifySmsController>(
                    id: "validate",
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          VerifyTextField(
                            textEditingController:
                                controller.textEditingController4,
                            focusNode: controller.focusNode4,
                          ),
                          VerifyTextField(
                            textEditingController:
                                controller.textEditingController3,
                            focusNode: controller.focusNode3,
                          ),
                          VerifyTextField(
                            textEditingController:
                                controller.textEditingController2,
                            focusNode: controller.focusNode2,
                          ),
                          VerifyTextField(
                            textEditingController:
                                controller.textEditingController1,
                            focusNode: controller.focusNode1,
                          ),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<VerifySmsController>(
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
                    }),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<VerifySmsController>(
                    id: "isLoading",
                    builder: (logic) {
                      return controller.isLoading
                          ? CircularProgressIndicator(
                              color: Color(0xFFF5DFD9),
                              backgroundColor: Color(0xFFDA7E70),
                              strokeWidth: 2,
                            )
                          : controller.resend
                              ? TextButton(
                                  onPressed: () {
                                    controller.sendAgain();
                                  },
                                  child: Text(
                                    "ارسال مجدد کد",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ))
                              : Obx(() {
                                  return Text(
                                    "ارسال مجدد تا ${controller.time.value}" +
                                        " ثانیه دیگر",
                                    style: TextStyle(color: Colors.grey),
                                  );
                                });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
