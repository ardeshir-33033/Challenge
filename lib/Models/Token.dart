import 'User.dart';

class Token {
  String? expiry;
  String? token;
  User? user;

  Token({this.expiry, this.token, this.user});

  Token.fromJson(Map<String, dynamic> json) {
    expiry = json['expiry'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expiry'] = this.expiry;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
