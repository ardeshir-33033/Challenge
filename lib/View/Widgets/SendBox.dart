import 'package:behtarino/Controllers/ChatController.dart';
import 'package:flutter/material.dart';

class SendBox extends StatelessWidget {
  const SendBox({
    Key? key,
    required this.controller,
    required this.userToken,
    required this.userId,
  }) : super(key: key);

  final ChatController controller;
  final String userToken;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFF6BEB1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                controller.sendMessage(
                    userToken: userToken, sendUserId: userId);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(Icons.send),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextField(
                controller: controller.messaageController,
                decoration: InputDecoration(
                    hintText: "نوشتن پیام....", border: InputBorder.none),
                onSubmitted: (val) {
                  controller.sendMessage(
                      userToken: userToken, sendUserId: userId);
                },
              ),
            ))
          ],
        ));
  }
}
