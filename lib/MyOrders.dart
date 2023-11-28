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
  final String username, name, email, phone, address, cnic, doctor, image, orderdate, orderimage, status;

  Spacecraft({
    this.id,
    this.username,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.cnic,
    this.image,
    this.doctor,
    this.orderdate,
    this.orderimage,
    this.status
  });

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
        id: jsonData['id'],
        username: jsonData['username'],
        name: jsonData['name'],
        email: jsonData['email'],
        image: jsonData['image'],
         phone:jsonData['phone'],
         address: jsonData['address'],
         cnic: jsonData['cnic'],
         doctor: jsonData['doctor'],
         orderdate: jsonData['orderdate'],
         orderimage: jsonData['orderimage'],
         status: jsonData['status']
         
         );
       
  }
}

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
   String loginusername = "", loginemail = "";
  void getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loginusername = sharedPreferences.getString("username");
      loginemail = sharedPreferences.getString("email");

      print(loginemail);
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
        await http.post(ApiUrls.fetchmyorders + "?nochache=1", body: {
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
        title: Text('My Orders'),
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
                      Text("Pharmacy Name: " +filteredorders[index].username,
                          style: GoogleFonts.lato(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 20,
                              ),
                      Text("Receicer Email: "+filteredorders[index].email,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                           Text("Receiver Phone: "+filteredorders[index].phone,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                           Text("Receiver CNIC: "+filteredorders[index].cnic,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                           Text("Receiver Address: "+filteredorders[index].address,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                          SizedBox(
                            height: 20,
                          ),
                           Text("Referral Doctor: "+filteredorders[index].doctor,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                    ],
                  ),
                ]),
               
                Container(
                              height: 300,
                              width: double.infinity,
                              margin: new EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                
                                image: DecorationImage(
                                  image: NetworkImage(ApiUrls.imagepath + filteredorders[index].orderimage)

                                )
                              ),
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [

                //   InkWell(
                //    onTap: () {
                //      updateAppointment(filteredorders[index].id, "Deleivered");
                              
                //             },
                //   child: Container(
                //     height: 50,
                //     width: 150,
                   
                //     decoration: BoxDecoration(
                //       color: Colors.green,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 15),
                //       child: Text('Deleivered',
                //           style: GoogleFonts.lato(
                //               fontSize: 15, fontWeight: FontWeight.w600, color:Colors.white),
                //           textAlign: TextAlign.center),
                //     ),
                //   ),
                // ),
                
                // ],),
              
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
