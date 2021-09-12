import 'package:behtarino/Controllers/Services/ContactService.dart';
import 'package:behtarino/Models/ContactModel.dart';
import 'package:behtarino/View/Pages/ChatPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactCard extends StatelessWidget {
  final ContactModel contactModel;
  ContactCard({required this.contactModel});

  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        ContactService.userId = contactModel.name;
        Get.to(() => Chat(
              name: contactModel.name!,
              userToken: contactModel.token!,
              userId: contactModel.id!,
            ));
      },
      child: Container(
        height: 70,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 5.5, top: 5.5, left: 16),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/beth.png",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          contactModel.name ?? "نام وارد نشده.",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          contactModel.lastMessage ??
                              "هنوز پیامی ارسال نکرده اید....",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 9, left: 8),
                        child: Text(
                          contactModel.seen ?? "هیچگاه",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
