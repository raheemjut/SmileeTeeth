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
  final String username, bio, image, status, email, regno, datetime;

  Spacecraft(
      {
 this.id,
    this.image,
  this.bio,
  this.username,
  this.status,
  this.email,
  this.regno,
  this.datetime
      });

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
      id: jsonData['id'],
      bio: jsonData['bio'],
      image: jsonData['image'],
      username: jsonData['username'],
      status: jsonData['status'],
      email: jsonData['email'],
      regno: jsonData['regno'],
      datetime: jsonData['datetime']
    );
  }
}
class ViewUsers extends StatefulWidget {
  

  @override
  _ViewUsersState createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {
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
        await http.post(ApiUrls.fetchadminpharmacy + "?nochache=1", body: {
       "status": "Customer"
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
   Future<List> updateAppointment(String userid, String status) async {
    final response = await http.post(ApiUrls.updateadminuserstatus, body: {
      "userid": userid,
      "status":status
    
    });
    var message = jsonDecode(response.body);
    print(message);
    var arr = message.split('*');
     if (arr[0] == "pass") {
      if (response.statusCode == 200) {
        setState(() {
          showMessage("User Updated", Colors.green, Colors.white);
          downloadJSON();
//  Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (BuildContext context) => ViewPharmacy()));

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
                               (element.username
                                   .toLowerCase()
                                   .contains(string.toLowerCase())) ||
                               (element.bio
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
            height: 5,
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
                      Text(filteredorders[index].username,
                          style: GoogleFonts.lato(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 5,
                              ),
                      Text(filteredorders[index].bio,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                          SizedBox(
                            height: 5,
                          ),
                             Text("Email: "+filteredorders[index].email,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                           SizedBox(
                            height: 10,
                          ),
                             Text("Reg #"+filteredorders[index].regno,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                           SizedBox(
                            height: 10,
                          ),
                    ],
                  ),
                ]),
               
              filteredorders[index].status == "Active" ?
                InkWell(
                   onTap: () {
                     updateAppointment(filteredorders[index].id, "Deactive");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Requestmedicine(
                              //       pharmacyid: filteredorders[index].id,
                              //       userid: loginemail,
                              //     ),
                              //   ),
                              // );
                            },
                  child: Container(
                    height: 50,
                    width: 180,
                    margin: new EdgeInsets.only(left:35),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Deactive User',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ) :
                InkWell(
                   onTap: () {
                     updateAppointment(filteredorders[index].id, "Active");
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Requestmedicine(
                              //       pharmacyid: filteredorders[index].id,
                              //       userid: loginemail,
                              //     ),
                              //   ),
                              // );
                            },
                  child: Container(
                    height: 50,
                    width: 180,
                    margin: new EdgeInsets.only(left:35),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Active User',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                
                SizedBox(
                  height: 15,
                ),
               
                Padding(
                  padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 10),
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