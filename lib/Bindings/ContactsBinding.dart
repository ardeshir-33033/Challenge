import 'package:behtarino/Controllers/ContactListController.dart';
import 'package:get/get.dart';

class ContactsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ContactsController());
  }
}
