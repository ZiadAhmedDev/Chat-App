import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/Constants.dart';
import 'package:scholar_chat/Models/Message_Model.dart';


import '../Widget/Chat_Buble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  CollectionReference message =
      FirebaseFirestore.instance.collection('Message');

  TextEditingController controller = TextEditingController();
  ScrollController _scrollControl = ScrollController();

  @override
  Widget build(BuildContext context) {
    var emailAddress = ModalRoute.of(context)?.settings.arguments ?? 'user++';
    return StreamBuilder<QuerySnapshot>(
        stream: message.orderBy('CreatedAt', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(
                Message.fromJson(snapshot.data!.docs[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 70,
                    ),
                    const Text('Chat')
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _scrollControl,
                        itemCount: messageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return messageList[index].id == emailAddress
                              ? ChatBuble(message: messageList[index])
                              : ChatBubleForFriend(message: messageList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        message.add({
                          'Message': data,
                          'CreatedAt': DateTime.now(),
                          'id': emailAddress
                        });
                        controller.clear();
                        _scrollControl.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: kPrimaryColor),
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text("Something went wrong");
          } else {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Loading.....',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
              ),
            );
          }
        });
  }
}
