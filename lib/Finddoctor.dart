// @dart=2.9
import 'dart:convert';

import 'package:finalproject/Book.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'Config.dart';


class Spacecraft {
  final String id;
  final String username, bio, image;

  Spacecraft(
      {
 this.id,
    this.image,
  this.bio,
  this.username,
      });

  factory Spacecraft.fromJson(Map<String, dynamic> jsonData) {
    return Spacecraft(
      id: jsonData['id'],
      bio: jsonData['bio'],
      image: jsonData['image'],
      username: jsonData['username']
    );
  }
}

class Finddoctor extends StatefulWidget {

  @override
  _FinddoctorState createState() => _FinddoctorState();
}

class _FinddoctorState extends State<Finddoctor> {
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
        await http.post(ApiUrls.fetchDoctors + "?nochache=1", body: {
      // "phonenumber": sharedPreferences.getString("phonenumber"),
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
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back)),
        title: Text('Available Dentist'),
        centerTitle: true,
      ),
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
                      Text("Dr. "+filteredorders[index].username,
                          style: GoogleFonts.lato(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 10,
                              ),
                      Text(filteredorders[index].bio,
                          style: GoogleFonts.lato(
                            fontSize: 15,
                          )),
                    ],
                  ),
                ]),
               
                InkWell(
                   onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Book(
                                    doctorid: filteredorders[index].id,
                                    userid: loginemail,
                                  ),
                                ),
                              );
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
                      child: Text('Book Appointment',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
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
      ],
    )
   
   
   
    );
  }
}
