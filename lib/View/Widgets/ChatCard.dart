import 'package:behtarino/Models/ChatModel.dart';
import 'package:behtarino/Utilities/Base.dart';
import 'package:behtarino/Utilities/DataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ChatCard extends StatelessWidget {
  final ChatModel chatModel;
  final String? token;
  // final int index;
  Function(int id, String token, String type)? deleteCallback;

  ChatCard({required this.chatModel, this.token, this.deleteCallback});
  bool showUserMessage = true;
  bool showServerMessage = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: chatModel.userMessage != "",
                child: GestureDetector(
                  onLongPress: () {
                    deleteCallback!(chatModel.id!, token!, "u");
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 25, bottom: 15),
                      width: CBase().getFullWidth(context) / 1.8,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBDEAC),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Text(
                          chatModel.userMessage ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: chatModel.serverMessage != "",
                child: GestureDetector(
                  onLongPress: () {
                    deleteCallback!(chatModel.id!, token!, "m");
                  },
                  child: Container(
                      width: CBase().getFullWidth(context) / 1.8,
                      decoration: BoxDecoration(
                        color: Color(0xFFF6BEB1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        child: Text(
                          chatModel.serverMessage ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
