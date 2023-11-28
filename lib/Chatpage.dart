//@dart=2.9


import 'package:finalproject/model/message.dart';
import 'package:finalproject/model/user.dart';
import 'package:finalproject/widget/messages_widget.dart';
import 'package:finalproject/widget/new_message_widget.dart';
import 'package:finalproject/widget/profilr_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final String receiverid, phonenumber;

  const ChatPage({
    @required this.receiverid,this.phonenumber,
    Key key,
  }) : super(key: key);
  // final User user;

  // const ChatPage({
  //   @required this.user,
  //   Key key,
  // }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final focusNode = FocusNode();
  Message replyMessage;
    void getUser() async{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
       
        sharedPreferences.setString("clicked", "y");
        sharedPreferences.setString("num", "0");
        print("object");
       
      });
   }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();

  }
  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
          child: Container(
          
            child: Column(
              children: [
                ProfileHeaderWidget(name: widget.receiverid),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    
                    decoration: BoxDecoration(
                      
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                      image: DecorationImage(
                image:AssetImage("assets/images/chatbg.png"),
                fit: BoxFit.fill,
                
                
              )
                    ),
                    child: MessagesWidget(
                      idUser: widget.phonenumber,
                      onSwipedMessage: (message) {
                        replyToMessage(message);
                        focusNode.requestFocus();
                      },
                    ),
                  ),
                ),
                NewMessageWidget(
                  focusNode: focusNode,
                  idUser: widget.phonenumber,
                  onCancelReply: cancelReply,
                  replyMessage: replyMessage,
                )
              ],
            ),
          ),
        ),
      );

  void replyToMessage(Message message) {
    setState(() {
      replyMessage = message;
    });
  }

  void cancelReply() {
    setState(() {
      replyMessage = null;
    });
  }
}