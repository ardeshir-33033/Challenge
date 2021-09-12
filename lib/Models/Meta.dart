import 'Token.dart';
import 'Detail.dart';

class Meta {
  int? statusCode;
  bool? paginated;
  Detail? detail;

  Meta({this.statusCode, this.paginated, this.detail});

  Meta.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    paginated = json['paginated'];
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['paginated'] = this.paginated;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }

    return data;
  }
}
