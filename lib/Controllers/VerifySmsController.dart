import 'dart:async';

import 'package:behtarino/Controllers/Services/SignUpServices.dart';
import 'package:behtarino/Models/Meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerifySmsController extends GetxController {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

  var time = 30.obs;
  Timer? timer;
  String? errorMessage;
  bool validate = true;
  bool isLoading = false;
  bool resend = true;

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    super.dispose();
  }

  getToken() async {
    isLoading = true;
    update(["isLoading"]);
    Meta meta = await SignUpService().TokenSign(
      textEditingController1.text +
          textEditingController2.text +
          textEditingController3.text +
          textEditingController4.text,
    );
    isLoading = false;
    update(["isLoading"]);
    if (meta.statusCode == 200) {
      validate = true;
      update(["validate"]);
      Get.offAllNamed("/Contacts");
    } else if (meta.statusCode == 400) {
      validate = false;
      errorMessage = meta.detail!.nonFieldErrors!.first;
      update(["validate"]);
    } else if (meta.statusCode == 404) {
      errorMessage = "شماره یافت نشد.";
      validate = false;
      update(["validate"]);
    } else {
      errorMessage = meta.detail!.globalErrorMessages!.first;
      validate = false;
      update(["validate"]);
    }
  }

  bool emptyCheck() {
    if (textEditingController1.text.isEmpty ||
        textEditingController2.text.isEmpty ||
        textEditingController3.text.isEmpty ||
        textEditingController4.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  finishCheck() {
    if (emptyCheck()) {
      getToken();
    }
  }

  sendAgain() async {
    Meta meta = await SignUpService().Verification(SignUpService.phoneNumber!);
    if (meta.statusCode == 200) {
      startTimer();
      resend = false;
      time.value = 29;
      update(["isLoading"]);
    } else {
      errorMessage = "در ارسال دوباره SMS سیستم به مشکل برخوزد.";
      update(["validate"]);
    }
  }

  void startTimer() {
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (time.value < 2) {
        resend = true;
        update(["isLoading"]);
        timer.cancel();
      } else {
        time.value = time.value - 1;
      }
    });
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String oldText = oldValue.text;
    String newText = newValue.text;

    int oLen = oldText.length;
    int nLen = newText.length;
    if (nLen == 1) {
      if (newText != '0') {
        newText = oldText;
      }
    } else if (nLen == 2) {
      if (newText.substring(1, 2) != '9') {
        newText = oldText;
      }
    } else if (nLen == 4 && oLen != 5) {
      newText += ' ';
    } else if (nLen == 5) {
      if (oLen == 6) {
        newText = newText.substring(0, 4);
      } else if (oLen == 4) {
        newText = '${newText.substring(0, 4)} ${newText.substring(4, 5)}';
      }
    } else if (nLen == 8 && oLen != 9) {
      newText += ' ';
    } else if (nLen == 9) {
      if (oLen == 10) {
        newText = newText.substring(0, 8);
      } else if (oLen == 8) {
        newText = '${newText.substring(0, 8)} ${newText.substring(8, 9)}';
      }
    } else if (nLen > 13) {
      newText = oldText;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
