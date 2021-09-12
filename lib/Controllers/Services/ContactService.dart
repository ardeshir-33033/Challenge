import 'package:behtarino/Api/Api.dart';
import 'package:behtarino/Api/Enums.dart';
import 'package:behtarino/Models/ContactModel.dart';

class ContactService extends Api {
  static String? userId;

  Future<List<ContactModel>?> getContacts() async {
    var res = await HTTPGET(
      "https://factor.behtarino.com/utils/challenge/contact_list/",
      [],
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (res.meta!.statusCode == 200) {
      return ContactModel().listFromJson(res.data);
    } else {
      return null;
    }
  }

  getUserID() {
    return userId;
  }

  setUserID(String id) {
    userId = id;
  }
}
