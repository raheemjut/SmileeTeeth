// ignore_for_file: import_of_legacy_library_into_null_safe
//@dart=2.9

import 'dart:convert';
import 'dart:ui';

import 'package:finalproject/Config.dart';
import 'package:finalproject/Contactus.dart';
import 'package:finalproject/Feedbacks.dart';
import 'package:finalproject/Finddoctor.dart';
import 'package:finalproject/Findpharmacy.dart';
import 'package:finalproject/Login.dart';
import 'package:finalproject/Password.dart';
import 'package:finalproject/Pharmahome.dart';
import 'package:finalproject/Prescription.dart';
import 'package:finalproject/Profile.dart';
import 'package:finalproject/myappointments.dart';
import 'package:finalproject/myorders.dart';
import 'package:finalproject/terms.dart';
import 'package:finalproject/userchatpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        title: Text('Home',
            style: TextStyle(color: Colors.white)),

            actions: [
              InkWell(
                 onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentsChatsPage()));
                  },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.message, size: 30,),
                ),
              )
            ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Drawer(
          
            child: ListView(
          children: [
           Container(
               
                         color: Colors.deepPurpleAccent,
                      child: new UserAccountsDrawerHeader(
                        
                        accountName: Text(
                          loginusername.toUpperCase(),
                          style: GoogleFonts.getFont("Lora",
                              color: Colors.white, fontSize: 20),
                        ),
                        accountEmail: Text(
                     loginemail,
                          style: GoogleFonts.getFont("Lora",
                              color: Colors.white, fontSize: 12),
                        ),
                        currentAccountPicture: GestureDetector(
                          child:        Container(
                                width: 150.0,
                                height: 150.0,
                                    child:MaterialButton(
                                      onPressed: () {
                                        //print("hello");
                                        //chooseImage();
                                     //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeProfile()));
                                        
                                      },
                                       // color: Colors.black,
                                      textColor: Colors.white,
                                      padding: EdgeInsets.only(left: 90,top: 120),
                                     
                                        shape: CircleBorder(),),
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                    shape: BoxShape.circle,
                                   image: new DecorationImage(
                                     
                                          fit: BoxFit.fill,
                                          image: AssetImage("assets/images/logo2.png")
                                         // image: NetworkImage("https://www.pinclipart.com/picdir/middle/148-1486972_mystery-man-avatar-circle-clipart.png"),
                                        )
                                )
                                ) ,
                   
                        ),
                        decoration: new BoxDecoration(
                        color:  Colors.deepPurpleAccent,
                        ),
                        
                      ),
                    ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.home_filled,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Home',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
               
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 160),
                  child:
                      Text('My Account', style: GoogleFonts.lato(fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.person_outline_outlined,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Profile',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                  ),
                ),
                InkWell(
                  onTap: (){
                     Navigator.push(context, 
                     MaterialPageRoute(builder: (context)=>MyOrder())
                     );
                   },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(Icons.shopping_cart_outlined)),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'My Orders',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                  ),
                ),
                 InkWell(
                   onTap: (){
                     Navigator.push(context, 
                     MaterialPageRoute(builder: (context)=>MyOrderA())
                     );
                   },
                   child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(Icons.shopping_cart_outlined)),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'My Appointments',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                ),
                 ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => Password(),
                //       ),
                //     );
                //   },
                //   child: Container(
                //     height: 50,
                //     width: double.infinity,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(0),
                //     ),
                //     child: Row(children: [
                //       Padding(
                //         padding: const EdgeInsets.only(left: 20),
                //         child: Icon(Icons.lock_outline,
                //             color: Colors.black.withOpacity(0.9), size: 25),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 40),
                //         child: Text(
                //           'Change Password',
                //           style: GoogleFonts.lato(
                //               fontSize: 15, fontWeight: FontWeight.w700),
                //         ),
                //       )
                //     ]),
                //   ),
                // ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180),
                  child: Text('Support', style: GoogleFonts.lato(fontSize: 15)),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AgentsChatsPage()));
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.chat_rounded,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Chat With Doctors',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Contactus(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.phone_forwarded,
                          size: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Contact Us',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Feedbacks(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(Icons.feedback),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Send feedbacks',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsandCondition()));
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(Icons.description)),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Terms & Conditions',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>Login())
                    );
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Icon(Icons.logout, size: 25)),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.lato(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Welcome ' + loginusername.toUpperCase(),
                  style: GoogleFonts.roboto(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          SizedBox(height:20),
          Container(
            height: 130,
            width: 130,
            child: Image(
              image: AssetImage('assets/images/logo2.png'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 120,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Finddoctor()),
              );
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          child: Image(
                            image: AssetImage('assets/images/doctor.png'),
                          ),
                        ),
                        Text(
                          'Find & Book Doctors',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Findpharmacy()),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.red.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 60,
                          child: Image(
                            image: AssetImage('assets/images/lab.png'),
                          ),
                        ),
                        Text(
                          'Buy Medicine',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          // Container(
          //   height: 320,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Colors.deepPurple,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(50),
          //       topRight: Radius.circular(50),
          //     ),
          //   ),
          //   child: Column(children: [
          //     Padding(
          //       padding: const EdgeInsets.only(top: 30),
          //       child: Text(
          //         'Today Appointments',
          //         style: GoogleFonts.ubuntu(
          //             fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          //       ),
          //     ),
              
          //   ]),
          // ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8),
            child: Container(
              height: 50,
                   width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child:   Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    'Today\'s Appointments',
                    style: GoogleFonts.ubuntu(
                        fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
            Expanded(

                 child: Padding(
                   padding: const EdgeInsets.only(left:8.0,right: 8),
                   child: Container(
                     width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(50),
              //   topRight: Radius.circular(50),
              // ),
            ),
                     child: ListView.builder(
                      
                // padding: EdgeInsets.only(top:40.0),
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
                                  height: 60,
                                  width: 60,
                                 
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            AssetImage('assets/images/profile.png'))):
                          Container(
                                  height: 100,
                                  width: 100,
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
                                  fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
                                  SizedBox(
                                    height: 20,
                                  ),
                          Text("Appointment Time: "+filteredorders[index].apttime,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                 color: Colors.white
                              )),
                              SizedBox(
                                height: 20,
                              ),
                               Text("Appointment Date: "+filteredorders[index].aptdate,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                 color: Colors.white
                              )),
                        ],
                      ),
                ]),
                SizedBox(
                      height: 20,
                ),
              
                   Padding(
                    padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 10),
                    child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                ),
              ],
            ),
          );
         
          
  
  
                }
                     ),
                   ),
                 )
            ),
      
        
        
        
        ],
      ),
   
   
   
    );
  }
}
