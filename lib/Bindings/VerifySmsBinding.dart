import 'package:behtarino/Controllers/SignUpController.dart';
import 'package:behtarino/Controllers/VerifySmsController.dart';
import 'package:get/get.dart';

class VerifySmsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(VerifySmsController());
  }
}
