import 'package:finalproject/Completeorder.dart';
import 'package:finalproject/Contactus.dart';
import 'package:finalproject/Login.dart';
import 'package:finalproject/Message.dart';
import 'package:finalproject/Profile.dart';
import 'package:finalproject/Requests.dart';
import 'package:finalproject/doctorchatpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Doctorhome extends StatefulWidget {
  const Doctorhome({Key? key}) : super(key: key);

  @override
  _DoctorhomeState createState() => _DoctorhomeState();
}

class _DoctorhomeState extends State<Doctorhome> {
  String loginusername = "", loginemail = "";
  void getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loginusername = sharedPreferences.getString("username")!;
      loginemail = sharedPreferences.getString("email")!;

      print(loginusername);
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Text("Doctor Panel" ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor:  Color(0xffE7EAB5),
      body: ListView(
        children: [
        
          Container(
            height: 140,
            padding: new EdgeInsets.only(top:15),
            width: double.infinity,
            color: Colors.deepPurple.withOpacity(0.9),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                                                child: Image(image: AssetImage('assets/images/profile.png'),fit: BoxFit.fill),

                    ),
                    
                    
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome Dr. "+loginusername, style: GoogleFonts.lora(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ), ),
                   
                    
                    
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'My Account',
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 180,
            color: Colors.white,
            child: Column(
              children: [
               
               
                SizedBox(
                  height: 15,
                ),
                InkWell(
                   onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorChatsPage(),
                                ),
                              );
                            },
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.message_outlined,
                            size: 35,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Messages',
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 190),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                   onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Request(),
                                ),
                              );
                            },
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.description_outlined,
                            size: 35,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Appointments Requests',
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 75),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                   onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Completeorder(),
                                ),
                              );
                            },
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.task_alt_outlined,
                            size: 35,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Completed Appointments',
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 68),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'General',
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 320,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
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
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.person_outline_outlined,
                            size: 35,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'My Profile',
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 180),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
               
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Contactus()));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.support,
                          size: 35,
                          color: Colors.green,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Contact Customer Support',
                          style: GoogleFonts.lato(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45),
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                 Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.share_outlined,
                        size: 35,
                        color:Colors.green
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        'Share Profile',
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.logout_outlined,
                            size: 35,
                            color: Colors.green,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            'Logout',
                            style: GoogleFonts.lato(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
