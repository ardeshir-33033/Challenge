import 'dart:convert';
import 'package:behtarino/Models/Token.dart';
import 'package:behtarino/Utilities/AutoLoginPref.dart';
import 'package:http/http.dart' as http;
import 'package:behtarino/Api/Api.dart';
import 'package:behtarino/Api/Enums.dart';
import 'package:behtarino/Models/Meta.dart';
import 'package:behtarino/Models/ResponseModel.dart';

class SignUpService extends Api {
  static String? token;
  static String? phoneNumber;

  Future<Meta> Verification(String phone) async {
    phoneNumber = phone;
    var json = jsonEncode({"phone": "$phone"});

    var response = await HTTPPOST(
      "https://factor.behtarino.com/api/v1/users/phone_verification/",
      [],
      json,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response.meta!;
  }

  Future<Meta> TokenSign(String sms) async {
    var json = jsonEncode({"username": "$phoneNumber", "password": "$sms"});

    ResponseModel response = await HTTPPOST(
      "https://factor.behtarino.com/api/v1/token_sign/",
      [],
      json,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.meta!.statusCode == 200) {
      Token res = Token.fromJson(response.data);
      token = res.token;
      await SharedPreferencePath().setUserDataInSharePrefrences(token!);
    }
    return response.meta!;
  }
}
