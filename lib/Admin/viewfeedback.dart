//@dart=2.9
import 'dart:convert';

import 'package:finalproject/Config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
class Spacecraft {
  final String id;
  final String  email, message;

  Spacecraft(
      {
 this.id,
  this.email,
  this.message,

      });

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
      id: jsonData['id'],
 
      email: jsonData['email'],
    
      message: jsonData['message'],
    
  
    );
  }
}
class ViewFeedbacks extends StatefulWidget {
  

  @override
  _ViewFeedbacksState createState() => _ViewFeedbacksState();
}

class _ViewFeedbacksState extends State<ViewFeedbacks> {
   String loginusername = "", loginemail = "";
  void getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loginusername = sharedPreferences.getString("username");
      loginemail = sharedPreferences.getString("email");

      print(loginusername);
    });
  }
    bool loading = true;
    List<Spacecraft> orders = List();
  List<Spacecraft> filteredorders = List();
   Future<List<Spacecraft>> downloadJSON() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response =
        await http.post(ApiUrls.fetchadminfeedback + "?nochache=1", body: {
     
    });
    //final response = await get(jsonEndpoint);
    //print(response.body);
    if (response.statusCode == 200) {
      List spacecrafts = json.decode(response.body);
      return spacecrafts
          .map((spacecraft) => new Spacecraft.fromJson(spacecraft))
          .toList();
    } else
      throw Exception(
          'We were not able to successfully download the json data.');
  }
   void showMessage(String message, Color bgclrvalue, Color txtclrvalue) {
    Toast.show(
      message,
      context,
      backgroundRadius: 0,
      backgroundColor: bgclrvalue,
      textColor: txtclrvalue,
      duration: Toast.LENGTH_SHORT,
      gravity: Toast.BOTTOM,
    );
  }
 
    @override
  void initState() {
    super.initState();
    getUser();
    downloadJSON().then((usersfromserver) {
      setState(() {
        orders = usersfromserver;
        filteredorders = orders;
        loading = false;
      });
    });
 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: Column(

      children: [
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 45,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  )),
              child: TextField(
                onChanged: (string){
                    setState(() {
                       filteredorders = orders
                           .where((element) =>
                               (element.email
                                   .toLowerCase()
                                   .contains(string.toLowerCase())) ||
                               (element.message
                                   .toLowerCase()
                                   .contains(string.toLowerCase())) 
                              
                                   
                                   )
                           .toList();
                     });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.blue.shade900),
                  border: InputBorder.none,
                  fillColor: Colors.black,
                  contentPadding: new EdgeInsets.only(top: 10),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        Expanded(

                 child: ListView.builder(
                  
                padding: EdgeInsets.all(0.0),
                itemCount: filteredorders.length,
                itemBuilder: (BuildContext context, int index) {
                    return new     Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
             
                  Padding(
                    padding: const EdgeInsets.only(left:30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Email: "+filteredorders[index].email,
                            style: GoogleFonts.lato(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 10,
                                ),
                  
                          
                               Text("Message: "+filteredorders[index].message,
                            style: GoogleFonts.lato(
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                ]),
         
               
               Padding(
                  padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 10,top: 10),
                  child: Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
         
          
  
  
                }
                 )
            ),
      ],
    )
   
   
    );
  }
}