import 'dart:async';
import 'dart:convert';

import 'package:behtarino/Controllers/ContactListController.dart';
import 'package:behtarino/Controllers/Services/ContactService.dart';
import 'package:behtarino/Models/ChatModel.dart';
import 'package:behtarino/Utilities/DataBaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'Services/MQTTservice.dart';

class ChatController extends GetxController {
  TextEditingController messaageController = TextEditingController();
  List<ChatModel> chatList = [];
  bool isLoading = true;
  String? userId;

  @override
  void onReady() async {
    // TODO: implement onReady
    userId = ContactService.userId;
    getChatData();
    super.onReady();
  }

  getChatData() async {
    if (userId != null) {
      chatList = await DataBase().grabChat(userId!);
    }
    isLoading = false;
    update(["Loading"]);
  }

  saveChat(server, user) async {
    chatList.add(ChatModel(serverMessage: server, userMessage: user));

    await DataBase().insertChat(
        [ChatModel(serverMessage: server, userMessage: user)],
        userId.toString());
  }

  ///send message and set lastMessage in contacts page
  sendMessage({required String userToken, required int sendUserId}) async {
    var client;
    var data;

    client = await MQTTCore().connection(userToken, messaageController.text);
    data = client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
      print(message.payload.message);
      // final payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
      final payload = utf8.decode(message.payload.message);

      if (payload != null) {
        saveChat(payload, messaageController.text);
        messaageController.clear();
      }

      ContactsController contactsController = Get.find();
      contactsController.contactList!.forEach((element) {
        if (element.id == sendUserId) {
          element.lastMessage = payload;
          contactsController.update(["Loading"]);
          return;
        }
      });
      update(["chat"]);
    });
  }

  ///just deleting message
  deleteMessage(int index, int id, String token, String type) {
    if (type == "u") {
      if (chatList[index].serverMessage == "") {
        chatList.removeAt(index);
        DataBase().deleteUser(id, token);
      } else {
        chatList[index].userMessage = "";
        DataBase().updateUser(id, token, type);
      }
    } else {
      if (chatList[index].userMessage == "") {
        chatList.removeAt(index);
        DataBase().deleteUser(id, token);
      } else {
        chatList[index].serverMessage = "";
        DataBase().updateUser(id, token, type);
      }
    }

    update(["chat"]);
  }

  ///recently message when message deleted
  updateContactPage({required int sendUserId, required int index}) {
    String message = '';
    if (chatList.length > index + 1) {
      message = chatList.last.userMessage!;
    } else if (chatList.length == index + 1) {
      if (chatList[index].userMessage != "") {
        message = chatList[index].userMessage!;
      } else if (chatList[index].serverMessage != "") {
        message = chatList[index].serverMessage!;
      }
    } else {
      message = chatList.last.userMessage!;
    }
    ContactsController contactsController = Get.find();
    contactsController.contactList!.forEach((element) {
      if (element.id == sendUserId) {
        element.lastMessage = message;
        contactsController.update(["Loading"]);
        return;
      }
    });
  }
}
