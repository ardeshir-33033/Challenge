class ChatModel {
  String? userMessage;
  String? serverMessage;
  int? id;
  ChatModel({this.serverMessage, this.userMessage, this.id});

  ChatModel.fromMap(Map<String, dynamic> res)
      : userMessage = res["userMessage"],
        id = res["id"],
        serverMessage = res["serverMessage"];

  Map<String, dynamic> toMap() {
    final map = {'userMessage': userMessage, 'serverMessage': serverMessage};
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
