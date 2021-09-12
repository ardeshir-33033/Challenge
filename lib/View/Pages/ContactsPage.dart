import 'package:behtarino/Controllers/ContactListController.dart';
import 'package:behtarino/View/Widgets/ContactWidgets/Contact.dart';
import 'package:behtarino/View/Widgets/ContactWidgets/RickPic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsPage extends GetView<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<ContactsController>(
              id: "Loading",
              builder: (_) {
                return controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(0xFFF5DFD9),
                        backgroundColor: Color(0xFFDA7E70),
                        strokeWidth: 2,
                      ))
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 26, bottom: 38),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 31),
                                    child: Icon(Icons.search)),
                                RickPic()
                              ],
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: controller.contactList!.length,
                                  itemBuilder: (context, index) {
                                    return ContactCard(
                                      contactModel:
                                          controller.contactList![index],
                                    );
                                  }))
                        ],
                      );
              })),
    );
  }
}
