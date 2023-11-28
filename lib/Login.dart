// ignore_for_file: unused_import

import 'dart:convert';

import 'package:finalproject/Admin/mainscreen.dart';
import 'package:finalproject/DoctorHome.dart';
import 'package:finalproject/Home.dart';
import 'package:finalproject/Medicinehome.dart';

import 'package:finalproject/Pharmahome.dart';
import 'package:finalproject/Register.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Config.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailaddresscontroller = new TextEditingController();
  final passwordcontroller = new TextEditingController();
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

  void setUser(String username, String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
print(username);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("username", username);
    print("Values set for login");
  }

 Future<List> loginUser() async {
  
    final response = await http.post(ApiUrls.loginurl, body: {
      //  "cnic": cniccontroller.text,
      "email": emailaddresscontroller.text,
      "password": passwordcontroller.text,
    });
    var message = jsonDecode(response.body);
    print(message);
    var arr = message.split('*');
    if (arr[0] == "exists") {
      if (response.statusCode == 200) {
        setState(() {
          showMessage("Login Successfully", Colors.green, Colors.white);
          setUser(arr[3], arr[1]);

            if(arr[2] == "Customer")
            {
 Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
            }
            else if(arr[2] == "Doctor")
            {
 Navigator.push(
              context, MaterialPageRoute(builder: (context) => Doctorhome()));
            }
            else if(arr[2]=="Pharmacist")
            {
 Navigator.push(
              context, MaterialPageRoute(builder: (context) => Medicinehome()));
            }
             else if(arr[2]=="Admin")
            {
 Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminMainScreen()));
            }
            else {
              showMessage("Account not found", Colors.green, Colors.white);
            }
         
        });
      }
    } else if (arr[0] == "not") {
      setState(() {
        showMessage(
            "Invalid username or password or your account is not approved yet", Colors.red, Colors.white);
      });
    } else {
      setState(() {
        showMessage("Failed to connect", Colors.red, Colors.white);
      });
    }
    return message;
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      body: 
      SingleChildScrollView(
        child: Column(
          
          children:[
            
             Container(
            decoration:BoxDecoration(
               image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.fitWidth)
             ),
            child: Column(
        
              children: [
                SizedBox(
                  height: 250,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 240),
                      child: Text(
                        'Login',
                        style: GoogleFonts.ubuntu(
                            fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 140),
                      child: Text('Please Sign in to Countinue',
                          style: GoogleFonts.ubuntu(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1000,
                ),
                Center(
                  child: Container(
                    
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 20, 17, 17),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: TextField(
                     controller: emailaddresscontroller,

                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Container(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.email_outlined, color: Colors.grey),
                          ),
                        ),
                         contentPadding: new EdgeInsets.only(top: 18,),
                        
                        hintText: '  Email Address',
                      
                        hintStyle: TextStyle(
                          
                          
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                 SizedBox(
                  height: 20,
                ),
                Container(
                  height: 100,
                  width: 5000,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Container(
                          height: 20,
                          width: 20,
                          
                          child: Icon(Icons.lock_outline, color: Colors.grey),
                        ),
                      ),
                      
                      contentPadding: new EdgeInsets.only(top: 18,),
                      
                      hintText: '  Password',
                    
                      hintStyle: TextStyle(
                        
                        
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                       
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
               Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: InkWell(
                    onTap: () {
                      if (emailaddresscontroller.text == "") {
                        showMessage(
                            "Please enter email address", Colors.red, Colors.white);
                      } else if (passwordcontroller.text == "") {
                        showMessage(
                            "Please enter Password", Colors.red, Colors.white);
                      
                      } else {
                        loginUser();
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 22),
                        ),
                      ]),
                    ),
                  ),
                ),
             
              Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not have Account ! ',style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text(
                          ' Create Account',
                          style: GoogleFonts.ubuntu(
                              color: Colors.lightGreen, fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ]),
      ),
    );
  }
}