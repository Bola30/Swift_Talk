import 'package:flutter/material.dart';
import 'package:swift_talk_2/core/utils/costants.dart';
import 'package:swift_talk_2/models/messages.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key ,required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: AppInfo.kPrimaryColor2,
        ),
        child: Text(message.textMessage , style: TextStyle(color: Colors.white),),// models
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({super.key , required this.friendmessage});
  final Message friendmessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 20, bottom: 20, right: 20),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: AppInfo.kPrimaryColor4,
        ),
        child: Text(friendmessage.textMessage , style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
