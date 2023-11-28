// @dart=2.9

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


import 'Config.dart';

class Spacecraft {
  final String id;
  final String username, status, aptdate, apttime, image;

  Spacecraft({
    this.id,
    this.username,
    this.aptdate,
    this.apttime,
    this.status,
    this.image
  });

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
        id: jsonData['id'],
        username: jsonData['username'],
        aptdate: jsonData['aptdate'],
        apttime: jsonData['apttime'],
        image: jsonData['image'],
         status:jsonData['status']);
       
  }
}

class MyOrderA extends StatefulWidget {
  @override
  _MyOrderAState createState() => _MyOrderAState();
}

class _MyOrderAState extends State<MyOrderA> {
   String loginusername = "", loginemail = "";
  void getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loginusername = sharedPreferences.getString("username");
      loginemail = sharedPreferences.getString("email");

      print(loginusername);
    });
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
    bool loading = true;

        List<Spacecraft> orders = List();
  List<Spacecraft> filteredorders = List();
   Future<List<Spacecraft>> downloadJSON() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final response =
        await http.post(ApiUrls.fetchmybookings + "?nochache=1", body: {
      "email": sharedPreferences.getString("email"),
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
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text('Appointment Bookings'),
      ),
      body: 
      
      Column(children: [
          Expanded(

                 child: ListView.builder(
                  
                padding: EdgeInsets.all(0.0),
                itemCount: filteredorders.length,
                itemBuilder: (BuildContext context, int index) {
                    return new     Container(
                      margin: new EdgeInsets.only(top:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                   Center(
                     child:
                     filteredorders[index].image == "N/A" ?
                     Container(
                              height: 70,
                              width: 70,
                             
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/images/profile.png'))):
                      Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(ApiUrls.imagepath + filteredorders[index].image),
                                    )),
                   ),
                   SizedBox(
                     width: 40,
                   ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Dr. " +filteredorders[index].username,
                          style: GoogleFonts.lato(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 20,
                              ),
                      Text("Appointment Time: "+filteredorders[index].apttime,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                           Text("Appointment Date: "+filteredorders[index].aptdate,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                    ],
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
              
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ],
            ),
          );
         
          
  
  
                }
                 )
            ),
      
      ],)
    );
  }
}
