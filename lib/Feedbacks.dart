import 'dart:convert';

import 'package:finalproject/Config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
class Feedbacks extends StatefulWidget {
  const Feedbacks({Key? key}) : super(key: key);

  @override
  _FeedbacksState createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();
  final numberController = new TextEditingController();
  final messageController = new TextEditingController();
    String loginusername = "", loginemail = "", loginpicture = "";
  void getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loginusername = sharedPreferences.getString("username")!;
      loginemail = sharedPreferences.getString("email")!;
      nameController.text = loginusername;
      emailController.text = loginemail;
      print(loginusername);
    });
  }
   bool isloading = true;
  Future<List> fetchUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response = await http.post(ApiUrls.fetchUser, body: {
      //  "cnic": cniccontroller.text,
      "email": sharedPreferences.getString("email"),
    });
    var message = jsonDecode(response.body);
    print(message);
    var arr = message.split('*');
    if (arr[0] == "exists") {
      if (response.statusCode == 200) {
        setState(() {
          numberController.text = arr[3];
       
          isloading = false;
        });
      }
    }
    return message;
  }
void showMessage(String message, Color bgclrvalue, Color txtclrvalue) {
    Toast.show(
      message,
      context,
      backgroundRadius: 0,
      backgroundColor: bgclrvalue,
      textColor: txtclrvalue,
      duration: Toast.LENGTH_SHORT,
    );
  }
  Future<List> contactusform() async {
    final response = await http.post(ApiUrls.feedback, body: {
     
      "email": emailController.text,
     
      "message": messageController.text,
    });
    var message = jsonDecode(response.body);
    print(message);
    var arr = message.split('*');
     if (arr[0] == "pass") {
      if (response.statusCode == 200) {
        setState(() {
          showMessage("Thanks For Your Valuable Feedback.", Colors.green, Colors.white);
          Navigator.pop(context);

          
        });
      }
    }  
    else {
      setState(() {
        showMessage("Failed to connect", Colors.red, Colors.white);
      });
    }
    return message;
  }
   @override
  void initState() {
    super.initState();
    getUser();
    fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: InkWell(
             
            onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back)),
          title: Text('Feedback'),
          ),
      body: 
      isloading
          ? Center(child: new CircularProgressIndicator())
          :
      ListView(children: [
        Column(
          children: [
            Container(
              height: 600,
              width: double.infinity,
              margin:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only( top: 10),
                    child: Text(
                      'Please send us Feedback',
                      style: GoogleFonts.lato(fontSize: 16),
                    ),
                  ),
                 
                  Visibility(
                    visible: false,
                    child: Container(
                      height: 50,
                      width: 350,
                      child: TextField(
                        controller: nameController,
                        readOnly: true,
                          decoration: InputDecoration(
                            
                        hintText: 'Your Name',
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: 350,
                    child: TextField(
                      controller: emailController,
                       readOnly: true,
                        decoration: InputDecoration(
                      hintText: 'Your Email',
                    )),
                  ),
                
                  Visibility(
                    visible: false,
                    child: Container(
                      height: 50,
                      width: 350,
                      child: TextField(
                         readOnly: true,
                        controller: numberController,
                          decoration: InputDecoration(
                        hintText: 'Your Number',
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    child: TextField(
                      controller: messageController,
                        maxLines: 4,
                        maxLength: 500,
                        decoration: InputDecoration(
                          hintText: 'Your Ideas/Issues',
                        )),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 5,
                  ),
                  child: InkWell(
                    onTap: (){
                      if(messageController.text == "")
                      {
                        showMessage("Please Enter Message", Colors.red, Colors.white);
                      }
                      else
                      {
                        contactusform();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 130,bottom: 5),
                            child: Text(
                              'Send Feedback',
                              style: GoogleFonts.lato(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
