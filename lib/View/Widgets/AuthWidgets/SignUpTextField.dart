import 'package:behtarino/Controllers/SignUpController.dart';
import 'package:behtarino/Controllers/VerifySmsController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpTextField extends StatelessWidget {
  const SignUpTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignUpController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
            color: controller.validate ? Colors.grey : Colors.red, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: controller.signUpTextController,
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "شماره تلفن همراه خود را وارد کنید.",
                    hintStyle: TextStyle(fontSize: 15)),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                  PhoneNumberFormatter()
                ],
                onChanged: (value) {
                  controller.buttonValidator(value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: VerticalDivider(
              width: 0.5,
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.asset("assets/images/iran.png"),
          ),
        ],
      ),
    );
  }
}
