import 'package:behtarino/Models/ContactModel.dart';
import 'package:get/get.dart';

import 'Services/ContactService.dart';

class ContactsController extends GetxController {
  bool isLoading = true;
  List<ContactModel>? contactList;

  @override
  void onReady() {
    // TODO: implement onReady
    addContacts();
    super.onReady();
  }

  addContacts() async {
    var res = await ContactService().getContacts();
    if (res != null) {
      isLoading = false;
      contactList = res;
      update(["Loading"]);
    }
  }
}
