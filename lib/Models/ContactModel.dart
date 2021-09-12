class ContactModel {
  String? name;
  String? lastMessage;
  String? seen;
  int? id;
  String? token;

  ContactModel({this.name, this.lastMessage, this.seen, this.token, this.id});

  ContactModel.fromJson(Map json) {
    name = json['name'];
    id = json['id'];
    token = json["token"];
  }

  List<ContactModel>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ContactModel>((ct) {
        return ContactModel.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
