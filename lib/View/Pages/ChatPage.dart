import 'package:behtarino/Controllers/ChatController.dart';
import 'package:behtarino/Utilities/Base.dart';
import 'package:behtarino/View/Widgets/AnimatedPortal.dart';
import 'package:behtarino/View/Widgets/BackButton.dart';
import 'package:behtarino/View/Widgets/ChatCard.dart';
import 'package:behtarino/View/Widgets/ContactWidgets/RickPic.dart';
import 'package:behtarino/View/Widgets/SendBox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {
  final String name;
  final String userToken;
  final int userId;

  Chat({required this.name, required this.userToken, required this.userId});

  ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: SendBox(
          controller: controller,
          userToken: userToken,
          userId: userId,
        ),
        body: Stack(
          children: [
            GetBuilder<ChatController>(
              id: "Loading",
              builder: (logic) {
                return controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFF5DFD9),
                          backgroundColor: Color(0xFFDA7E70),
                          strokeWidth: 2,
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: CBase().getFullWidth(context) / 20,
                                vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                backButton(),
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 5.5, top: 5.5, left: 16),
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/beth.png",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GetBuilder<ChatController>(
                            id: "chat",
                            builder: (logic) {
                              return controller.chatList.length == 0
                                  ? Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom:
                                                CBase().getFullHeight(context) /
                                                    12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 12),
                                              child: AnimatedPortal(),
                                            ),
                                            Text(
                                              "هنوز به این دنیا وارد نشدی." +
                                                  "\n" +
                                                  "یه پورتال بزن به گوشی رفیقت.",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                          itemCount: controller.chatList.length,
                                          itemBuilder: (context, index) {
                                            return ChatCard(
                                              chatModel:
                                                  controller.chatList[index],
                                              token: controller.userId,
                                              deleteCallback: (int id,
                                                  String token, String type) {
                                                controller.deleteMessage(
                                                    index, id, token, type);
                                                controller.updateContactPage(
                                                    sendUserId: userId,
                                                    index: index);
                                              },
                                            );
                                          }),
                                    );
                              // });
                            },
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
