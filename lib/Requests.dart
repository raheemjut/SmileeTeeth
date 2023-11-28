// @dart=2.9

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:io';

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

class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
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
        await http.post(ApiUrls.fetchbookings + "?nochache=1", body: {
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

   Future<List> updateAppointment(String appointmentid, String status) async {
    final response = await http.post(ApiUrls.updateapt, body: {
      "aptid": appointmentid,
      "status":status
    
    });
    var message = jsonDecode(response.body);
    print(message);
    var arr = message.split('*');
     if (arr[0] == "pass") {
      if (response.statusCode == 200) {
        setState(() {
          showMessage("Appointment Updated", Colors.green, Colors.white);
 Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Request()));

          //     Navigator.push(context,
          //  MaterialPageRoute(builder: (context)=>Medicinehome())
          //  );
        });
      }
    }  else {
      setState(() {
        showMessage("Failed to connect", Colors.red, Colors.white);
      });
    }
    return arr [0];
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
                      Text("Patient Name: " +filteredorders[index].username,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                  InkWell(
                   onTap: () {
                     updateAppointment(filteredorders[index].id, "Confirmed");
                              
                            },
                  child: Container(
                    height: 50,
                    width: 150,
                   
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Accept',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w600, color:Colors.white),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                InkWell(
                   onTap: () {
                              updateAppointment(filteredorders[index].id, "Rejected");
                             
                            },
                  child: Container(
                    height: 50,
                    width: 150,
                  
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Reject',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w600,color:Colors.white),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                ],),
                SizedBox(
                  height: 15,
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
