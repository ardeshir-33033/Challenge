import 'Token.dart';
import 'Meta.dart';

class ResponseModel {
  Meta? meta;
  dynamic data;

  ResponseModel({this.meta, this.data});

  ResponseModel fromJson<T>(dynamic jsn) {
    this.meta = Meta.fromJson(jsn['meta']);
    this.data = jsn["data"];

    return this;
  }

  // ResponseModel.fromJson(Map<String, dynamic> json) {
  //   meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  //   data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
