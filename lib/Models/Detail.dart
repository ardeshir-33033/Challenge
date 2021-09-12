class Detail {
  bool? ok;
  List<String>? globalErrorMessages;
  List<dynamic>? nonFieldErrors;

  Detail({this.ok, this.globalErrorMessages, this.nonFieldErrors});

  Detail.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    globalErrorMessages = json['global_error_messages'];
    nonFieldErrors = json['non_field_errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['global_error_messages'] = this.globalErrorMessages;
    return data;
  }
}
