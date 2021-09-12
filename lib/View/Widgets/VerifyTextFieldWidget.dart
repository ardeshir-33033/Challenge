import 'package:behtarino/Controllers/VerifySmsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerifyTextField extends GetView<VerifySmsController> {
  const VerifyTextField({
    Key? key,
    required this.textEditingController,
    required this.focusNode,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: controller.validate ? Colors.grey : Colors.red,
                width: 0.5)),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
          controller: textEditingController,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: (val) {
            if (textEditingController.text.length != 0) {
              FocusScope.of(context).previousFocus();
            } else {
              FocusScope.of(context).nextFocus();
            }
            controller.finishCheck();
          },
        ));
  }
}
