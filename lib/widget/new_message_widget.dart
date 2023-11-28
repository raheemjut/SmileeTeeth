//@dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:finalproject/Config.dart';
import 'package:finalproject/model/message.dart';
import 'package:finalproject/widget/reply_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class NewMessageWidget extends StatefulWidget {
  final FocusNode focusNode;
  final String idUser;
  final Message replyMessage;
  final VoidCallback onCancelReply;

  const NewMessageWidget({
    @required this.focusNode,
    @required this.idUser,
    @required this.replyMessage,
    @required this.onCancelReply,
    Key key,
  }) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';
  void showMessage(String message, Color bgclrvalue, Color txtclrvalue) {
    Toast.show(message, context,
        backgroundRadius: 0,
        backgroundColor: bgclrvalue,
        textColor: txtclrvalue,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.TOP);
  }

  static final inputTopRadius = Radius.circular(12);
  static final inputBottomRadius = Radius.circular(24);
  File uploadimage;

  Future<List> signupUser() async {
    FocusScope.of(context).unfocus();
    widget.onCancelReply();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.post(ApiUrls.sendchat, body: {
      "message": _controller.text,
      "senderphone": sharedPreferences.getString("email"),
      "receiverphone": widget.idUser,
      "status": ""
    });
    var message = jsonDecode(response.body);
    print(message);
   setState(() {
      _controller.clear();
   });
    if (message == "pass") {
      if (response.statusCode == 200) {
        setState(() {
          _controller.text = "";
        });
      }
    } else {
      setState(() {});
    }
  }

  bool sending = true;
  Future<void> uploadImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      List<int> imageBytesproduct = uploadimage.readAsBytesSync();
      String baseimageproduct = base64Encode(imageBytesproduct);

      //convert file image to Base64 encoding

      var response = await http.post(ApiUrls.sendchat, body: {
        "message": _controller.text,
       
        "senderphone": sharedPreferences.getString("email"),
        "receiverphone": widget.idUser,
        "status": baseimageproduct,
        "image": ""
      });
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        print(jsondata);
        if (jsondata["error"]) {
          print(jsondata["msg"]);
        } else {
          print(jsondata["msg"]);
          // setState(() {
          //   sending = false;
          // });
          //   Navigator.pushReplacement(
          // context,
          // MaterialPageRoute(
          //     builder: (BuildContext context) => Profile()));
          print("Upload successful");
          _controller.text = "";
        }
      } else {
        _controller.text = "";
        print("Error during connection to server");
      }
    } catch (e) {
      print(e);
      print("Error during converting to Base64");
    }
  }

  bool typing = true;
  final picker = ImagePicker();


 Future<void> cameraImageCamera() async {
    var choosedimage = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = choosedimage;
    });
  }

  Future<void> chooseImageGallery() async {
    try {
      var choosedimage = await ImagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      //set source: ImageSource.camera to get image from camera
      setState(() {
        uploadimage = choosedimage;
      });
    } catch (e) {
      print("gallery not responding");
    }
  }
  // void sendMessage() async {
  //   FocusScope.of(context).unfocus();
  //   widget.onCancelReply();

  //   try {
  //     await FirebaseApi.uploadMessage(
  //         widget.idUser, message, widget.replyMessage);
  //   } catch (e) {
  //     Scaffold.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('You have been banned for using bad words'),
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }

  //   _controller.clear();
  // }

  @override
  Widget build(BuildContext context) {
    final isReplying = widget.replyMessage != null;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/chatbg.png"),
        fit: BoxFit.fill,
      )),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          FutureBuilder<File>(
            builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  null != snapshot.data) {
                return Flexible(
                  child: Image.file(
                    snapshot.data,
                    fit: BoxFit.fill,
                  ),
                );
              } else if (null != snapshot.error) {
                return const Text(
                  'Error Picking Image',
                  textAlign: TextAlign.center,
                );
              } else {
                return const Text(
                  '',
                  textAlign: TextAlign.center,
                );
              }
            },
          ),
          Expanded(
            child: Column(
              children: [
                if (isReplying) buildReply(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        // SizedBox(width: 8.0),
                        // // Icon(Icons.insert_emoticon,
                        // //     size: 30.0, color: Theme.of(context).hintColor),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            focusNode: widget.focusNode,
                            controller: _controller,
                            textCapitalization: TextCapitalization.sentences,
                            autocorrect: true,
                            enableSuggestions: true,
                            maxLines: null,
                            // expands: true,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                                hintText: 'Type a message',
                                border: InputBorder.none
                                // border: OutlineInputBorder(
                                //     borderSide: BorderSide.none,
                                //     borderRadius: BorderRadius.only(
                                //       topLeft: isReplying ? Radius.zero : inputBottomRadius,
                                //       topRight: isReplying ? Radius.zero : inputBottomRadius,
                                //       bottomLeft: inputBottomRadius,
                                //       bottomRight: inputBottomRadius,
                                //     ),
                                //   ),
                                ),
                            onChanged: (value) {
                              setState(() {
                                if (value == "") {
                                  typing = true;
                                } else {
                                  typing = false;
                                }
                              });
                            },
                          ),
                        ),
                        
                        Visibility(
                          visible: true,
                          child: InkWell(
                            onTap: () {
                              chooseImageGallery();
                            },
                            child: Icon(Icons.attach_file,
                                size: 30.0,
                                color: Colors.grey.withOpacity(0.7)),
                          ),
                        ),
                        Visibility(
                            visible: typing, child: SizedBox(width: 8.0)),
                        Visibility(
                          visible: typing,
                          child: InkWell(
                            onTap: () {
                              cameraImageCamera();
                            },
                            child: Icon(Icons.camera_alt,
                                size: 30.0,
                                color: Colors.grey.withOpacity(0.7)),
                          ),
                        ),
                        SizedBox(width: 8.0),
                      ],
                    ),
                  ),
                )
                //               TextField(
                //                 focusNode: widget.focusNode,
                //                 controller: _controller,
                //                 textCapitalization: TextCapitalization.sentences,
                //                 autocorrect: true,
                //                 enableSuggestions: true,
                //                 maxLines: null,
                // // expands: true,
                //                 keyboardType: TextInputType.multiline,
                //                 textInputAction: TextInputAction.newline,
                //                 decoration: InputDecoration(
                //                   suffixIcon: Row(
                //                     crossAxisAlignment: CrossAxisAlignment.end,
                //                     mainAxisAlignment: MainAxisAlignment.end,
                //                     children: [
                //                       Icon(Icons.add),
                //                       Icon(Icons.attachment)
                //                     ],
                //                   ),
                //                   filled: true,
                //                   fillColor: Colors.grey[100],
                //                   hintText: 'Type a message',
                //                   border: OutlineInputBorder(
                //                     borderSide: BorderSide.none,
                //                     borderRadius: BorderRadius.only(
                //                       topLeft: isReplying ? Radius.zero : inputBottomRadius,
                //                       topRight: isReplying ? Radius.zero : inputBottomRadius,
                //                       bottomLeft: inputBottomRadius,
                //                       bottomRight: inputBottomRadius,
                //                     ),
                //                   ),
                //                 ),

                //                 // onChanged: (value) => setState(() {
                //                 //   message = value;
                //                 // }),
                //               ),
              ],
            ),
          ),
          SizedBox(width: 8),
          //  GestureDetector(
          //   onTap:(){
          //     // if(_controller.text == "")
          //     // {
          //     //     showMessage("Please enter message", Colors.red, Colors.white);
          //     // }else
          //     // {
          //     //   signupUser();
          //     // }
          //     getImageGallery();
          //   },
          //   child: Container(
          //     padding: EdgeInsets.all(8),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.blue,
          //     ),
          //     child: Icon(Icons.add, color: Colors.white),
          //   ),
          // ),
          // SizedBox(
          //   width: 5,
          // ),
          Container(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                if (uploadimage == null) {
                  if (_controller.text == "") {
                    showMessage(
                        "Please enter message", Colors.red, Colors.white);
                  } else {
                    signupUser();

                    setState(() {
                      
                      typing = true;
                    });
                  }
                } else {
                  _controller.text = "File Selected";
                  uploadImage();
                  setState(() {
                    
                    typing = true;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
                child: Icon(Icons.send, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReply() => Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: inputTopRadius,
            topRight: inputTopRadius,
          ),
        ),
        child: ReplyMessageWidget(
          message: widget.replyMessage,
          onCancelReply: widget.onCancelReply,
        ),
      );
}
