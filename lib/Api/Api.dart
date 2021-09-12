import 'dart:convert';
import 'package:behtarino/Controllers/Services/SignUpServices.dart';
import 'package:behtarino/Models/Detail.dart';
import 'package:behtarino/Models/Meta.dart';
import 'package:behtarino/Models/ResponseModel.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'Enums.dart';
import 'QueryModel.dart';

class Api {
  Map<String, String> bearerHeader = {
    // HttpHeaders.authorizationHeader: "Bearer ${SignUpService.token ?? ""}",
    'Authorization': "Token ${SignUpService.token}",
    "Accept": "application/json",
  };

  Map<String, String> formDataHeader = {
    "Accept": "multipart/form-data",
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String> basicHeader = {
    "Accept": "application/json",
    "content-type": "application/json; charset=utf-8",
  };

  Map<String, String>? headerGetter(HeaderEnum typeEnum) {
    switch (typeEnum) {
      // case HeaderEnum.ImageHeaderEnum:
      //   return imageHeader;
      //   break;
      case HeaderEnum.BearerHeaderEnum:
        return bearerHeader;
        break;
      case HeaderEnum.FormDataHeaderEnum:
        return formDataHeader;
        break;
      case HeaderEnum.BasicHeaderEnum:
        return basicHeader;
        break;
      case HeaderEnum.EmptyHeaderEnum:
        return null;
        break;
      default:
        return basicHeader;
    }
  }

  String GenerateQuery(List<QueryModel> queries) {
    String query = "";
    if (queries != null && queries.length > 0) {
      query += "?";
      queries.forEach((element) {
        if (element.value != null && element.value != "null") {
          String? nm = element.name;
          String? vl = element.value;

          query += "$nm=$vl&";
        }
      });
    }

    return query;
  }

  String UrlGenerator(String url, List<QueryModel> query) {
    var queryPart = GenerateQuery(query);

    return "$url$queryPart";
  }

  responseGetter<T>(ResponseEnum typeEnum, http.Response response) {
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          String data = utf8.decode(response.bodyBytes);

          if (data == null || data.isEmpty)
            return ResponseModel(
                meta: Meta(
              statusCode: 555,
            ));

          return ResponseModel().fromJson(
            json.decode(data),
          );
        default:
          return response.bodyBytes;
      }
    } catch (e) {
      return ResponseModel(
          meta: Meta(
              statusCode: 500,
              detail: Detail(globalErrorMessages: [
                "در ارتباط با سرور مشکلی پیش آمده است."
              ])));
    }
  }

  Future<ResponseModel> HTTPGET<T>(
    String url,
    List<QueryModel> query,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var dio = Dio();
      Options options = new Options();

      options.headers = {
        'Authorization': "Token ${SignUpService.token}",
        "Accept": "application/json"
      };

      var response = await dio.get(
          "https://factor.behtarino.com/utils/challenge/contact_list/",
          options: options);

      return responseDynamicGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(meta: Meta(statusCode: 500));
    }
  }

  Future<ResponseModel> HTTPDELETE<T>(
    String url,
    List<QueryModel> query,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var response = await http.delete(
        Uri.parse(UrlGenerator(url, query)),
        headers: headerGetter(headerType),
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(meta: Meta(statusCode: 500));
    }
  }

  Future<ResponseModel> HTTPPOST<T>(String url, List<QueryModel> query, var body,
      HeaderEnum headerType, ResponseEnum responseType) async {
    try {
      var response = await http.post(
        Uri.parse(UrlGenerator(url, query)),
        headers: headerGetter(headerType),
        body: body,
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(meta: Meta(statusCode: 500));
    }
  }

  Future<ResponseModel> HTTPPUT<T>(
    String url,
    List<QueryModel> query,
    var body,
    HeaderEnum headerType,
    ResponseEnum responseType,
  ) async {
    try {
      var response = await http.put(
        Uri.parse(UrlGenerator(url, query)),
        headers: headerGetter(headerType),
        body: body,
      );

      return responseGetter<T>(responseType, response);
    } catch (e) {
      return ResponseModel(meta: Meta(statusCode: 500));
    }
  }

  responseDynamicGetter<T>(ResponseEnum typeEnum, Response<dynamic> response) {
    try {
      switch (typeEnum) {
        case ResponseEnum.ResponseModelEnum:
          return ResponseModel().fromJson(response.data);
          break;
        default:
          return response.data.bodyBytes;
      }
    } catch (e) {
      return ResponseModel(
        meta: Meta(
            statusCode: 555,
            detail:
                Detail(globalErrorMessages: ["خطایی در عملیات رخ داده است"])),
        data: null,
      );
    }
  }
}
