import 'package:behtarino/Controllers/Services/SignUpServices.dart';
import 'package:behtarino/Models/Meta.dart';
import 'package:behtarino/Utilities/AutoLoginPref.dart';
import 'package:behtarino/View/Pages/ContactsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  TextEditingController signUpTextController = TextEditingController();

  String? errorMessage;

  bool activeButton = false;
  bool isLoading = false;
  bool validate = true;

  @override
  void onInit() {
    // TODO: implement onInit
    autoLogin();
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    signUpTextController.dispose();
    super.dispose();
  }

  autoLogin() async {
    String? token = await SharedPreferencePath().getUserDataInSharePrefrences();
    if (token != null) {
      SignUpService.token = token;
      Get.toNamed("/Contacts");
    }
  }

  buttonValidator(String number) {
    if (number.length == 13) {
      activeButton = true;
      update(["Button"]);
    } else {
      if (activeButton == true) {
        activeButton = false;
        update(["Button"]);
      }
    }
  }

  buttonPressed() async {
    if (activeButton) {
      isLoading = true;
      update(["Loading"]);
      // String val = signUpTextController.text.substring(0, 2);
      // if (val == "09") {
        String phone = signUpTextController.text.replaceAll(' ', '');
        Meta meta = await SignUpService().Verification(phone);

        if (meta.statusCode == 200) {
          validate = false;
          isLoading = false;
          update(["Loading", "validate"]);
          Get.toNamed("/VerifySms");
        } else {
          validate = false;
          isLoading = false;
          errorMessage = meta.detail!.globalErrorMessages!.first;
          update(["Loading", "validate"]);
        }
      }
      // else {
      //   errorMessage =
      //       "به نظر می‌آید شماره تلفن معتبری وارد نکرده‌اید، مجددا تلاش کنید";
      //   validate = false;
      //   isLoading = false;
      //   update(["Loading", "validate"]);
      // }
    // }
  }
}
