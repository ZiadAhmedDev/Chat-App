import 'package:flutter/material.dart';
import 'package:scholar_chat/Models/Message_Model.dart';

import '../Constants.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({required this.message});
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
              bottomRight: Radius.circular(36),
            )),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({required this.message});
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
              bottomLeft: Radius.circular(36),
            )),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
