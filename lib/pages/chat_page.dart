import 'package:flutter/material.dart';
import 'package:swift_talk_2/core/utils/costants.dart';
import 'package:swift_talk_2/models/messages.dart';
import 'package:swift_talk_2/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages = FirebaseFirestore.instance.collection(
    "messages",
  );

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          print(snapshot.data!.docs[0]['messages']);
          return Scaffold(
            appBar: AppBar(
              shadowColor: AppInfo.kPrimaryColor4,
              backgroundColor: const Color(0xFF792ef2),
              centerTitle: true,
              elevation: 2,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Text(
                    "SwiftTalk",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppInfo.kPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(AppInfo.kLogo3, height: 60, width: 60),
                ],
              ),
            ),
            body: Column(
              children: [
               /*  Expanded(
                  child: ListView.builder(
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return ChatBubleForFriend(friendmessage: messagesList[index]);
                    },
                  ),
                ), */
                Expanded(
                  child: ListView.builder(
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return ChatBuble(message: messagesList[index]);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          onSubmitted: (data) {
                            messages.add({'messages': data});
                            controller.clear();
                          },
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: "Send a Message",
                            hintStyle: Theme.of(context).textTheme.bodyMedium,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: AppInfo.kPrimaryColor2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: AppInfo.kPrimaryColor2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Send Button
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppInfo.kPrimaryColor2,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            /*    if (_message.text.trim().isNotEmpty) {
                        // Add your logic to send the message
                        print("Message Sent: ${_message.text}");
                        _message.clear(); // Clear the input field after sending
                      } */
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError == true) {
          return Scaffold(body: Container(child: Center(child: Text('404'))));
        } else {
          return Scaffold(
            body: Container(
              child: Center(
                child: Text(
                  'Loading...',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppInfo.kPrimaryColor2,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
