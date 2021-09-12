import 'dart:convert';

import 'package:behtarino/Controllers/Services/SignUpServices.dart';
import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MQTTCore {
  Future<MqttServerClient> connection(String token, String message) async {
    // SharedPreferences pref= await SharedPreferences.getInstance();
    // var token= pref.getString("token");
    MqttServerClient client =
        MqttServerClient.withPort('185.86.181.206', 'flutter_client', 31789)
          ..logging(on: true);

    final mqMessage = MqttConnectMessage()
        .authenticateAs('challenge', '8dAtPHvjPNC4erjFRfy')
        .withWillQos(MqttQos.exactlyOnce);

    client.connectionMessage = mqMessage;
    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      Get.snackbar("ارور", "در ارتباط با سرور مشکلی پیش آمده است");
      client.disconnect();
    }

    client.subscribe(
        "challenge/user/$token/${SignUpService.token}/", MqttQos.exactlyOnce);

    final builder = MqttClientPayloadBuilder();
    builder.addUTF8String(message);

    client.publishMessage('challenge/user/${SignUpService.token}/$token/',
        MqttQos.exactlyOnce, builder.payload!);

    return client;
  }
}
