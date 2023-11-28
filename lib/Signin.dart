import 'dart:convert';

import 'package:finalproject/Config.dart';
import 'package:finalproject/Home.dart';
import 'package:finalproject/Register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;



class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
 
  
  final fullnamecontroller = new TextEditingController();
  final emailcontroller = new TextEditingController();
  final passwordcontroller = new TextEditingController();
  final confirmpasswordcontroller = new TextEditingController();
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
  
  void setUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("username", fullnamecontroller.text);
    sharedPreferences.setString("email", emailcontroller.text);
    print("Values set for login");
  }

  Future<List> loginUser() async {
    final response = await http.post(ApiUrls.signupurl, body: {
      "username": fullnamecontroller.text,
      "email": emailcontroller.text,
      "password": passwordcontroller.text,
      "accounttype": 'Customer',
      "registrationno":"N/A",
      "phone":""
      
    });
   
    var message = jsonDecode(response.body);
   print(message);
    var arr = message.split('*');
     if (arr[0] == "pass") {
      if (response.statusCode == 200) {
        setState(() {
          showMessage("Account Created", Colors.green, Colors.white);


              Navigator.push(context,
           MaterialPageRoute(builder: (context)=>Home())
           );
        });
      }
    } else if (arr[0] == "exists") {
      setState(() {
        showMessage("Account Already Exist", Colors.red, Colors.white);
      });
    } else {
      setState(() {
        showMessage("Failed to connect", Colors.red, Colors.white);
      });
    }
    return arr [0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.fitWidth)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios, color: Colors.deepPurple, size: 30,)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 80),
                      child: Text(
                        'Create Account',
                        style: GoogleFonts.ubuntu(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: TextField(
                      controller: fullnamecontroller,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Container(
                            height: 20,
                            width: 20,
                            child:
                                Icon(Icons.person_outlined, color: Colors.grey),
                          ),
                        ),
                        contentPadding: new EdgeInsets.only(
                          top: 18,
                        ),
                        hintText: 'Username',
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
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: TextField(
                    controller: emailcontroller,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Container(
                          height: 20,
                          width: 20,
                          child: Icon(Icons.email_outlined, color: Colors.grey),
                        ),
                      ),
                      contentPadding: new EdgeInsets.only(
                        top: 18,
                      ),
                      hintText: '  Email ',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
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
                      contentPadding: new EdgeInsets.only(
                        top: 18,
                      ),
                      hintText: '  Password',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  child: TextField(
                    obscureText: true,
                    controller: confirmpasswordcontroller,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Container(
                          height: 20,
                          width: 20,
                          child: Icon(Icons.lock_outline, color: Colors.grey),
                        ),
                      ),
                      contentPadding: new EdgeInsets.only(
                        top: 18,
                      ),
                      hintText: ' Confirm Password',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                  SizedBox(
                  height: 20,
                ),
                
           
                Padding(
                  padding: const EdgeInsets.only(left: 200,top: 30),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Home(),
                      //     ));
                      if (fullnamecontroller.text == "") {
                        showMessage(
                            "Please enter full name", Colors.red, Colors.white);
                      } else if (emailcontroller.text == "") {
                        showMessage(
                            "Please enter Email", Colors.red, Colors.white);
                      } else if (passwordcontroller.text == "") {
                        showMessage(
                            "Please enter password", Colors.red, Colors.white);
                      } else if (confirmpasswordcontroller.text == "") {
                        showMessage("Please enter confirm password", Colors.red,
                            Colors.white);
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
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
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
                      Text('Already have Account..! ',style: GoogleFonts.ubuntu(fontWeight: FontWeight.w500),),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text(
                          ' Log In',
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
